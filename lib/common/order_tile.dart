import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/order.dart';
import 'package:operativo_final_cliente/screens/orders/components/cancel_order_dialog.dart';
import 'package:operativo_final_cliente/screens/orders/components/export_address_dialog.dart';
import 'package:operativo_final_cliente/screens/orders/components/order_product_tile.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final bool showControls;
  const OrderTile(this.order, {this.showControls = false});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.formattedId,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
                Text(
                  'Total: ${order.price.toStringAsFixed(2)} Kz',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Data: ${order.novaData}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 10,
                    fontStyle: FontStyle.italic
                  ),
                ),
              ],
            ),
            Text(
              order.statusText,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color:
                    order.status == Status.canceled ? Colors.red : primaryColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        children: [
          Column(
            children: order.items.map((e) {
              return OrderProductTile(e);
            }).toList(),
          ),
          if (showControls && order.status != Status.canceled)
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FlatButton(
                    onPressed:(){
                      showDialog(context: context,
                        builder: (_) => CancelOrderDialog(order)
                      );
                    },
                    textColor: Colors.red,
                    child: const Text('Cancelar'),
                  ),
                  FlatButton(
                    onPressed:order.back,
                    child: const Text('Recuar'),
                  ),
                  FlatButton(
                    onPressed:order.advance,
                    child: const Text('Avançar'),
                  ),
                  FlatButton(
                    onPressed:(){
                      showDialog(
                        context: context,
                        builder: (_) => ExportAddressDialog(order)
                      );
                    },
                    textColor: Theme.of(context).primaryColor,
                    child: const Text('Endereço'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
