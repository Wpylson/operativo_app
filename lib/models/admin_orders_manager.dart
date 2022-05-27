import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/order.dart';
import 'package:operativo_final_cliente/models/user.dart';

class AdminOrdersManager extends ChangeNotifier {
  final List<Order> _orders = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  StreamSubscription _subscription;
  User userFilter; //variavel para filtro
  List<Status> statusFilter = [Status.preparing];

  //Get Filtro
  List<Order> get filteredOrders {
    List<Order> output = _orders.reversed.toList();

    if (userFilter != null) {
      output = output.where((o) => o.userId == userFilter.id).toList();
    }

    return output =
        output.where((o) => statusFilter.contains(o.status)).toList();
  }

  void updateAdmin({bool adminEnabled}) {
    _orders.clear();

    _subscription?.cancel(); //se nao é null call o cancel
    if (adminEnabled) {
      _listenToOrders();
    }
  }

  void _listenToOrders() {
    _subscription = firestore.collection('orders').snapshots().listen((event) {
      for (final change in event.docChanges) {
        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(
              Order.fromDocuments(change.doc),
            );
            break;
          case DocumentChangeType.modified:
            final modOrders =
                _orders.firstWhere((o) => o.orderId == change.doc.id);
            modOrders.updateFromDocument(change.doc);
            break;
          case DocumentChangeType.removed:
            debugPrint('Bug.. big bug!!!');
            break;
        }
      }
      notifyListeners();
    });
  }

  void setUserFilter(User user) {
    userFilter = user;
    notifyListeners();
  }

  void setStatusFilter({Status status, bool enabled}) {
    if (enabled) {
      statusFilter.add(status);
    } else {
      statusFilter.remove(status);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subscription?.cancel(); //se nao e nulo chamar o cancel
  }
}
