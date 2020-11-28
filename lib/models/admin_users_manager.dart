import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:operativo_final_cliente/models/user.dart';
import 'package:operativo_final_cliente/models/user_manager.dart';

class AdminUsersManager extends ChangeNotifier{

  List<User> users =[];
  final Firestore firestore = Firestore.instance;
  StreamSubscription _subscription;

  void updateUser(UserManager userManager){
    _subscription?.cancel();
    if(userManager.adminEnabled){
      _listenToUsers();
    }else{
      users.clear();
      notifyListeners();
    }
  }

  void _listenToUsers(){
     _subscription = firestore.collection('users').snapshots().listen((snapshot){
      users = snapshot.documents.map((e) => User.fromDocument(e)).toList();
      //order uma lista por ordem alfa
      //order por nome
      users.sort((a,b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      notifyListeners();
    });
  }

  //get Lista de nomes
  List<String> get names => users.map((e) => e.name).toList();

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}