import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/price_card.dart';
import 'package:operativo_final_cliente/models/cart_manager.dart';
import 'package:operativo_final_cliente/models/checkout_manager.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //Sempre que haver uma alteracao no meu cart manager ira ser chamado o updateCart()
    return ChangeNotifierProxyProvider<CartManager,CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_,cartManager, checkoutManager) =>
      checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Pagamento'),
          centerTitle: true,
        ),
        body: Consumer<CheckoutManager>(
          builder: (_,checkoutManager,__){
            if(checkoutManager.loading){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                   const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),

                    ),
                    const SizedBox(height: 16,),
                    const Text(
                      'Processando seu pagamento...',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16
                      ),
                    ),
                  ],
                ),
              );
            }else{
            return ListView(
              children: [
                PriceCard(
                  buttonText: 'Finalizar Pedido',
                  onPressed: (){
                    checkoutManager.checkout(
                      onStockFail: (e){
                        Navigator.of(context).popUntil(
                            (route) => route.settings.name == '/cart');
                      },
                      onSuccess: (order){
                        Navigator.of(context).popUntil(
                                (route) => route.settings.name == '/');
                        Navigator.of(context).pushNamed(
                            '/confirmation',
                          arguments: order
                        );
                      }
                    );
                  },
                )
              ],
            );}
          },
        ),
      ),
    );
  }
}
