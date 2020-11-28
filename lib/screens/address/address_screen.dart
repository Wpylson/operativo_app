import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/price_card.dart';
import 'package:operativo_final_cliente/models/cart_manager.dart';
import 'package:operativo_final_cliente/screens/address/components/address_card.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: ListView(children: [
        AddressCard(),
        Consumer<CartManager>(
          builder: (_, cartManager, __) {
            return PriceCard(
              buttonText: 'Continuar para o pagamento',
              onPressed: cartManager.isAddressValid ? (){
                Navigator.of(context).pushNamed('/checkout');
              } : null,
            );
          },
        ),
      ]
      ),
    );
  }
}
