import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/product.dart';
import 'package:operativo_final_cliente/models/product_manger.dart';
import 'package:provider/provider.dart';

class DeleteDialog extends StatelessWidget {
    final String item;
    final String grupo;
    const DeleteDialog({this.item,this.grupo,this.product});
    final Product product;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      title:  Text(
        'Apagar $grupo?'
      ),
      content: Text(
        'Deseja apagar o produto  $item ?'
      ),
      actions: [
        FlatButton(
          onPressed: (){
            context.read<ProductManager>().delete(product);
            Navigator.of(context).pop();
            Navigator.of(context).pop();

          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Apagar'),
        )
      ],
    );
  }
}
