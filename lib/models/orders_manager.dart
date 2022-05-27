import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/order.dart';
import 'package:operativo_final_cliente/models/user.dart';

class OrdersManager extends ChangeNotifier {
  User user;
  List<Order> orders = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  StreamSubscription _subscription;

  void updateUser(User user) {
    this.user = user;
    orders.clear();

    _subscription?.cancel(); //se nao e nulo chamar o cancel
    if (user != null) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
    //TODO:buscar doc por id do user logado
    //Sempre que haver uma alteracao, limpacr a lista de pedidos
    _subscription = firestore
        .collection('orders')
        .where('user', isEqualTo: user.id)
        .snapshots()
        .listen((event) {
      orders.clear();
      for (final doc in event.docs) {
        orders.add(Order.fromDocuments(doc));
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subscription?.cancel(); //se nao e nulo chamar o cancel
  }
}
