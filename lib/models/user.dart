import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:operativo_final_cliente/models/address.dart';

class User{

  User({this.name, this.email,this.password,this.id});

  //Pegar os dados do user de um DocumentSnapshot
  User.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
    //Carregar o endereco do firebase
    if(document.data.containsKey('address')){
      address = Address.fromMap(document.data['address'] as Map<String,dynamic>);
    }
  }

  String id;
  String name;
  String email;
  String password;
  String confirmPassword;
  bool admin = false;
  Address address;
  final Firestore firestore = Firestore.instance;

  DocumentReference get firestoreRef =>
  //Firestore.instance.document('users/$id');

  // ignore: unnecessary_string_interpolations
  firestore.collection('citys').document('namibe').collection('users').document('$id');

  CollectionReference get cartReference =>
      firestoreRef.collection('cart');

  //Salvar os dados do user no Firestore utilizando um Map
  Future<void> saveData() async {
     await firestoreRef.setData(toMap());
  }

  Map<String,dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      if(address != null)
        'address': address.toMap(),
    };
  }

  void setAddress(Address address){
    this.address =address;
    saveData();
  }
}