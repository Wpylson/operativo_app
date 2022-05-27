import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:operativo_final_cliente/models/categorys.dart';

class CategoryManager extends ChangeNotifier {
  CategoryManager() {
    _loadAllCategorys();
  }
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Category> allCategorys = [];

  //Para pesquisar
  String _search = '';

  String get search => _search;
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Category> get filteredCategorys {
    final List<Category> filteredCategory = [];

    if (search.isEmpty) {
      filteredCategory.addAll(allCategorys);
    } else {
      filteredCategory.addAll(allCategorys
          .where((c) => c.title.toLowerCase().contains(search.toLowerCase())));
    }

    return filteredCategory;
  }

  Future<void> _loadAllCategorys() async {
    final QuerySnapshot snapCat = await firestore.collection('products').get();

    allCategorys = snapCat.docs.map((c) => Category.fromDocument(c)).toList();
    notifyListeners();
  }
}
