import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:operativo_final_cliente/models/product.dart';

class Category extends ChangeNotifier{

  List<Product> allProducts = [];
  String id;
  String title;
  String icon;

  //Atributos do prductos
  String pid;
  String description;
  String name;
  String images;

  final Firestore firestore = Firestore.instance;
  //Referencia do ID de um doc
  DocumentReference get firestoreRef => firestore.document('products/$id');


  Category.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    title = document['name'] as String;
    icon = document['image'] as String;

  }



  Future<void> _loadAllProduct()async{
    QuerySnapshot snapshot= await Firestore.instance.collection('products')
        .document(id).collection('items')
        .where('deleted',isEqualTo: false)
        .getDocuments();

    allProducts = snapshot.documents.map((e) => Product.fromDocument(e)).toList();
    notifyListeners();

  }


}