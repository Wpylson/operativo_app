import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/empty_card.dart';
import 'package:operativo_final_cliente/common/login_card.dart';
import 'package:operativo_final_cliente/common/price_card.dart';
import 'package:operativo_final_cliente/models/cart_manager.dart';
import 'package:operativo_final_cliente/screens/cart/componets/cart_tile.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_,cartManager,__){
          if(cartManager.user == null){
            return LoginCard();
          }

          if(cartManager.items.isEmpty){
            return const EmptyCard(
              iconData: Icons.remove_shopping_cart,
              title: 'Nenhum produto no carrinho',
            );
          }

          return ListView(
            children: [
              Column(
                children: cartManager.items.map(
                        (cartProduct) => CartTile(cartProduct)).toList(),
              ),
              PriceCard(
                buttonText: 'Continuar para Entrega',
                onPressed:cartManager.isCartValid ? (){
                  Navigator.of(context).pushNamed('/address');
                }:null,
              ),
            ],
          );
        },
      ),
    );
  }
}
