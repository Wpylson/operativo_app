import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Services extends ChangeNotifier{
  List<Services> allServices = [];
  String id;
  String icon;
  String title;


  Services.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    title = document['title'] as String;
    icon = document['icon'] as String;
  }


  @override
  String toString() {
    return 'Services{id: $id, icon: $icon, title: $title}';
  }
}