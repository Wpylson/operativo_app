import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/custom_icon_button.dart';
import 'package:operativo_final_cliente/models/cart_product.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;
  const CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed('/product',
          arguments: cartProduct.product);
        },
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(cartProduct.product?.images?.first),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartProduct.product.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Tamanho: ${cartProduct.size}',
                          style: const TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                      Consumer<CartProduct>(builder: (_, cartProduto, __) {

                        if(cartProduct.hasStock){
                          return Text(
                            '${cartProduct.unitPrice.toStringAsFixed(2)} Kz',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          );
                        }
                        else{
                          return const Text('Sem stock suficiente',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ),
              Consumer<CartProduct>(
                builder: (_, cartProduct, __) {
                  return Column(
                    children: [
                      CustomIconButton(
                        iconData: Icons.add,
                        color: primaryColor,
                        onTap: cartProduct.increment,
                      ),
                      Text(
                        '${cartProduct.quantity}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      CustomIconButton(
                        iconData: cartProduct.quantity > 1
                            ? Icons.remove
                            : Icons.delete,
                        color:
                            cartProduct.quantity > 1 ? primaryColor : Colors.red,
                        onTap: cartProduct.decrement,
                      ),
                    ],
                  );
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
