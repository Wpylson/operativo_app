import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/empty_card.dart';
import 'package:operativo_final_cliente/common/login_card.dart';
import 'package:operativo_final_cliente/common/order_tile.dart';
import 'package:operativo_final_cliente/models/orders_manager.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meus Pedidos',
        ),
        centerTitle: true,
      ),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, __) {
          if (ordersManager.user == null) {
            return LoginCard();
          }
          if (ordersManager.orders.isEmpty) {
            return const EmptyCard(
              title: 'Nenhuma compra encontrada!',
              iconData: Icons.border_clear,
            );
          }
          return ListView.builder(
            itemCount: ordersManager.orders.length,
            itemBuilder: (_, index) {
              return OrderTile(ordersManager.orders.reversed.toList()[index]);
            },
          );
        },
      ),
    );
  }
}
