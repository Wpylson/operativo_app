import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:operativo_final_cliente/models/item_size.dart';
import 'package:uuid/uuid.dart';

class Product extends ChangeNotifier {
  Product(
      {this.id,
      this.name,
      this.description,
      this.images,
      this.sizes,
      this.deleted = false}) {
    images = images ?? [];
    sizes = sizes ?? [];
  }

  //Pegar lista dos produtos
  Product.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document['images'] as List<dynamic>);
    price = document['price'] as num;
    deleted = (document['deleted'] ?? false) as bool;
    sizes = (document['sizes'] as List<dynamic> ?? [])
        .map((s) => ItemSize.fromMap(s as Map<String, dynamic>))
        .toList();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  //Referencia do ID de um doc
  DocumentReference get firestoreRef => firestore.doc('produtos/$id');
  //Firestorage- referencia da pasta onde serao guardadas as imagens de cada produto
  Reference get storageRef => storage.ref().child('products').child(id);

  String id;
  String name;
  String description;
  num price;
  List<String> images;
  List<ItemSize> sizes;

  bool deleted;
  List<dynamic> newImages;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  //Para podermo setar e pegar os tamanhos
  ItemSize _selectedSize;
  ItemSize get selectedSize => _selectedSize;

  set selectedSize(ItemSize value) {
    _selectedSize = value;
    notifyListeners();
  }

  //Get para verificar se tem stock
  int get totalStock {
    int stock = 0;
    for (final size in sizes) {
      stock += size.stock;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0 && !deleted;
  }

  //Preco que aparece na tela do produto
  num get basePrice {
    num lowest = double.infinity;
    for (final size in sizes) {
      if (size.price < lowest) {
        lowest = size.price;
      }
    }
    return lowest;
  }

  //pegar o tamanho e seu preço para add no cart
  ItemSize findSize(String name) {
    try {
      //Try catch caso o tamanho não é econtrado
      return sizes.firstWhere((s) => s.name == name);
    } catch (e) {
      return null;
    }
  }

  //Lista de Tamanhos
  List<Map<String, dynamic>> exportSizeList() {
    return sizes.map((size) => size.toMap()).toList();
  }

  //Save
  Future<void> save() async {
    loading = true;

    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'sizes': exportSizeList(),
      'deleted': deleted,
    };

    //Se o Id do produto é nulo é pk estou criando um novo produto ao senao é pk estou editando
    if (id == null) {
      final doc = await firestore.collection('produtos').add(data);
      id = doc.id;
    } else {
      await firestoreRef.update(data);
    }

    //Salvar imagens no Firestore
    final List<String> updateImages = [];

    for (final newImage in newImages) {
      if (images.contains(newImage)) {
        updateImages.add(newImage as String);
      } else {
        //TODO: Uuid
        final UploadTask task =
            storageRef.child(Uuid().v1()).putFile(newImage as File);
        final TaskSnapshot snapshot = await task.onComplete;
        final String url = snapshot.ref.getDownloadURL() as String;
        updateImages.add(url);
      }
    }

    //Verificar se a imagem esta sendo utilizada, caso nao a imagem sera escluida
    for (final image in images) {
      if (!newImages.contains(image) && image.contains('firebase')) {
        try {
          final ref = await storage.refFromURL(image);
          await ref.delete();
        } catch (e) {
          debugPrint('Falha ao apagar $image');
        }
      }
    }

    //Salvar a url da imagem referente ao produto no Firestore
    await firestoreRef.update({'images': updateImages});
    images = updateImages;

    loading = false;
  }

//apagar
  void delete() {
    firestoreRef.update({'deleted': true});
  }

  //Metodo que faz clone da class Product{}. Close pode sofrer alteracoes e nao afectar o original ate que as alteracoes sejam salvas
  Product clone() {
    return Product(
      id: id,
      name: name,
      description: description,
      images: List.from(images),
      sizes: sizes.map((size) => size.clone()).toList(),
      deleted: deleted,
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, images: $images, sizes: $sizes, newImages: $newImages}';
  }
}
