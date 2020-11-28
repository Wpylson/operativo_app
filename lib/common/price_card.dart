import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/cart_manager.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {

  final String buttonText;
  final VoidCallback onPressed;

  const PriceCard({this.buttonText,this.onPressed});
  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productPrice = cartManager.productPrice;
    final deliverPrice = cartManager.deliveryPrice;
    final totalPrice = cartManager.totalPrice;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child:Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
           const Text('Resumo do Pedido',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16
              ),
            ),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                const Text(
                  'Subtotal'
                ),
                 Text(
                    '${productPrice.toStringAsFixed(2)} Kz',
                ),
              ],
            ),

            const Divider(),
            if(deliverPrice != null)
              ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                        'Entrega'
                    ),
                    Text(
                      '${deliverPrice.toStringAsFixed(2)} Kz',
                    ),
                  ],
                ),
                const Divider(),
              ],
            const SizedBox(height: 12,),
         Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               const Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                 Text(
                   '${totalPrice.toStringAsFixed(2)} Kz',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 4, 125, 141),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8 ,),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              disabledColor: Theme.of(context).primaryColor.withAlpha(100),
              textColor: Colors.white,
              onPressed: onPressed,
              child:  Text(buttonText),
            )
          ],
        ),
      ) ,
    );
  }
}
