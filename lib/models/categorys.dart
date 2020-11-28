import 'package:cloud_firestore/cloud_firestore.dart';

class Category{

  Category.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    title = document['title'] as String;
    icon = document['icon'] as String;

  }


  String id;
  String title;
  String icon;
}