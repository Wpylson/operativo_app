import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:operativo_final_cliente/common/colors.dart';
import 'package:operativo_final_cliente/models/order.dart';
import 'package:screenshot/screenshot.dart';

class ExportAddressDialog extends StatelessWidget {
  final Order order;
  final ScreenshotController screenshotController = ScreenshotController();
  ExportAddressDialog(this.order);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Endereço de Entrega'),
      content: Screenshot(
        controller: screenshotController,
        child: Container(
          padding: const EdgeInsets.all(8),
          color: Colors.white,
          child: Text(
            'Pedido #00${order.orderId}\n'
            '${order.address.street}, ${order.address.number} ${order.address.complement}\n'
            '${order.address.district}\n'
            '${order.address.city}/${order.address.state}\n'
            'CEP: ${order.address.zipCode}',
          ),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            final file = await screenshotController.capture();
            await GallerySaver.saveImage(file);
          },
          style: TextButton.styleFrom(textStyle: TextStyle(color: amarela)),
          //textColor: Theme.of(context).primaryColor,
          child: const Text('Exportar'),
        )
      ],
    );
  }
}
