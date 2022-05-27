import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:operativo_final_cliente/models/product.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Product> allProducts = [];

  String id = 'pizza';
  //Para pesquisar
  String _search = '';

  String get search => _search;
  set search(String value) {
    _search = value;

    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];

    if (search.isEmpty) {
      filteredProducts.addAll(allProducts);
    } else {
      filteredProducts.addAll(
        allProducts.where(
          (p) => p.name.toLowerCase().contains(search.toLowerCase()),
        ),
      );
    }

    return filteredProducts;
  }

  Future<void> _loadAllProducts() async {
    final QuerySnapshot snapProducts = await firestore
        .collection('produtos')
        .where('deleted', isEqualTo: false)
        .get();

    allProducts =
        snapProducts.docs.map((d) => Product.fromDocument(d)).toList();

    notifyListeners();
  }

  //Categoria Produto
  /* Future<void> _loadAllProductsP() async {
    final QuerySnapshot snapshot = await Firestore.instance
        .collection('products')
        .doc('bebidas')
        .collection('items')
        .where('deleted', isEqualTo: false)
        .get();

    snapshot.documents.map((e) => Product.fromDocument(e)).toList();
    notifyListeners();
  }*/

  Product findProductByID(String id) {
    try {
      return allProducts.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void update(Product product) {
    allProducts.removeWhere((p) => p.id == product.id);
    allProducts.add(product);
    notifyListeners();
  }

  void delete(Product product) {
    product.delete();
    allProducts
        .removeWhere((p) => p.id == product.id); //remover da lista primeiro
    notifyListeners();
  }
}
