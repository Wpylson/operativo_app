import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:operativo_final_cliente/models/address.dart';

class Uuser {
  String id;
  String name;
  String email;
  String password;
  String confirmPassword;
  bool admin = false;
  Address address;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Uuser({this.name, this.email, this.password, this.id});

  DocumentReference get firestoreRef => firestore
      .collection('citys')
      .doc('namibe')
      .collection('users')
      .doc('$id');

  CollectionReference get cartReference => firestoreRef.collection('cart');

  //Pegar os dados do user de um DocumentSnapshot
  Uuser.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    email = document['email'] as String;
    //Carregar o endereco do firebase
    if (document.data.containsKey('address')) {
      address = Address.fromMap(document['address'] as Map<String, dynamic>);
    }
  }

  //Salvar os dados do user no Firestore utilizando um Map
  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      if (address != null) 'address': address.toMap(),
    };
  }

  void setAddress(Address address) {
    this.address = address;
    saveData();
  }
}
