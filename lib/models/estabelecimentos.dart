import 'package:cloud_firestore/cloud_firestore.dart';

class Estabelecimentos {
  String id;
  String name;
  String image;

  Estabelecimentos.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    //image = document['image'] as String;
  }
}
