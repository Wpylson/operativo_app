import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:operativo_final_cliente/models/section_item.dart';
import 'package:uuid/uuid.dart';

class Section extends ChangeNotifier {
  Section({this.id, this.name, this.type, this.items}) {
    items = items ??
        []; //se o meu item for null, vai colocar uma nova sessap caso nao, ira fazer nada
    originalItems = List.from(items);
  }

  Section.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    type = document['type'] as String;

    items = (document['items'] as List ?? [])
        .map((i) => SectionItem.fromMap(i as Map<String, dynamic>))
        .toList();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  //Referencia do ID de um doc
  DocumentReference get firestoreRef => firestore.doc('home/$id');
  //Firestorage- referencia da pasta onde serao guardadas as imagens de cada sessao
  Reference get storageRef => storage.ref().child('home/$id');

  String id;
  String name;
  String type;
  List<SectionItem> items;
  List<SectionItem> originalItems;

  String _error;
  String get error => _error;
  set error(String value) {
    _error = value;
    notifyListeners();
  }

  //Clonar a lista de sessao
  Section clone() {
    return Section(
      id: id,
      name: name,
      type: type,
      items: items.map((e) => e.clone()).toList(),
    );
  }

  //Add um novo item na sessao
  void addItem(SectionItem item) {
    items.add(item);
    notifyListeners();
  }

  //Remover um  item na sessao
  void removeItem(SectionItem item) {
    items.remove(item);
    notifyListeners();
  }

  //Salvar sessao
  Future<void> save(int pos) async {
    final Map<String, dynamic> data = {
      'name': name,
      'type': type,
      'pos': pos,
    };

    //Verificar se a sessao ja existia
    if (id == null) {
      //se id for null ou sessao nao existe criar a sessao no firestore e pegar o seu id
      final doc = await firestore.collection('home').add(data);
      id = doc.id;
    } else {
      await firestoreRef.update(data);
    }

    //Salvar Items no Firestore
    for (final item in items) {
      if (item.image is File) {
        final UploadTask task =
            storageRef.child(Uuid().v1()).putFile(item.image as File);
        final TaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        item.image = url;
      }
    }

    //Excluir items nao utilizados
    for (final original in originalItems) {
      if (!items.contains(original) &&
          (original.image as String).contains('firebase')) {
        try {
          final ref = storage.refFromURL(original.image as String);
          await ref.delete();
          // ignore: empty_catches
        } catch (e) {}
      }
    }

    final Map<String, dynamic> itemsData = {
      'items': items.map((e) => e.toMap()).toList()
    };

    await firestoreRef.update(itemsData);
  }

  Future<void> delete() async {
    await firestoreRef.delete();
    for (final item in items) {
      if ((item.image as String).contains('firebase')) {
        try {
          final ref = await storage.refFromURL(item.image as String);
          await ref.delete();
          // ignore: empty_catches
        } catch (e) {}
      }
    }
  }

  //Validar dados da sessao para salvar
  //Se erro é igual a nulo quer dizer que não há erro e vai retornar TRUE
  //Caso haja erro o erro será diferente de nulo irá retornar FALSE
  bool valid() {
    if (name == null || name.isEmpty) {
      error = 'Título inválido(Digite um título para sessão)';
    } else if (items.isEmpty) {
      error = 'Insira ao menos uma imagem para poder salvar a sessão';
    } else {
      error = null;
    }
    return error == null;
  }

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}
