import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/order.dart';

class CancelOrderDialog extends StatelessWidget {
  final Order order;
  const CancelOrderDialog(this.order);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Cancelar ${order.formattedId} ?',
        style: const TextStyle(
            fontSize: 18
      ),
      ),
      content: const Text('Esta acção não poderá ser desfeita!'),
      actions: [
        FlatButton(
            onPressed: () {
              order.cancel();
              Navigator.of(context).pop();
            },
            textColor: Colors.red,
            child: const Text('Cancelar Pedido'),
        ),
      ],
    );
  }
}
