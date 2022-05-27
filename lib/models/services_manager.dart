import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/services.dart';

class ServiceManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Services> allServices = [];
  String _search = '';

  ServiceManager() {
    _loadAllServices();
  }

  String get search => _search;
  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Services> get filteredServices {
    final List<Services> filteredService = [];

    if (search.isEmpty) {
      filteredService.addAll(allServices);
    } else {
      filteredService.addAll(allServices.where((services) =>
          services.title.toLowerCase().contains(search.toLowerCase())));
    }
    // ignore: avoid_print
    print('Lista de Serviços $filteredServices');
    return filteredService;
  }

  Future<void> _loadAllServices() async {
    // allServices = snapshot.documents.map((s) => Services.fromDocument(s)).toList();
    notifyListeners();
  }
}
