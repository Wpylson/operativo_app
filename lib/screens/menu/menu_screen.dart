import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/services_manager.dart';
import 'package:operativo_final_cliente/screens/menu/components/service_tile.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Serviços')),
      body: Consumer<ServiceManager>(
        builder: (_, serviceManager, __) {
          final filterServices = serviceManager.filteredServices;
          if (filterServices.isNotEmpty) {
            return ListView.builder(
              itemCount: filterServices.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: ServiceTile(filterServices[index]),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'Serviço nao encontrado!',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
