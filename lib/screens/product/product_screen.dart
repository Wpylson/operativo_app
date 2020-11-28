import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/cart_manager.dart';
import 'package:operativo_final_cliente/models/product.dart';
import 'package:operativo_final_cliente/models/user_manager.dart';
import 'package:operativo_final_cliente/screens/product/components/size_widget.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  final Product product;
  const ProductScreen(this.product);

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(//usar o contexto actual, nesse casso um produto especifico
      value: product,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(product.name),
          centerTitle: true,
          actions: [
            Consumer<UserManager>(
              builder: (_,userManager,__){
                if(userManager.adminEnabled && !product.deleted){
                  return IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed('/edit_product',
                      arguments: product);
                    },
                  );
                }else{
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: product.images.map((url){
                  return NetworkImage(url);
                }).toList(),
                dotSize: 4,
                dotSpacing: 15,
                dotColor: primaryColor,
                autoplay: false,
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top:8),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13
                      ),
                    ),
                  ),
                  Text(
                    '${product.basePrice.toStringAsFixed(2)} Kz',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:16,bottom: 8),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(
                      fontSize: 16
                    ),
                  ),
                  if(product.deleted)
                     const Padding(
                        padding:   EdgeInsets.only(top:16,bottom: 8),
                        child:  Text(
                         'Este produto não está mais disponível',
                          style: TextStyle(color: Colors.red, fontSize: 16,
                          fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                  else
                    ...[
                      Padding(
                        padding: const EdgeInsets.only(top:16,bottom: 8),
                        child: Text(
                          'Tamanhos',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: product.sizes.map((s){
                          return SizeWidget(size: s);
                        }).toList(),
                      ),
                    ],
                  const SizedBox(height: 20,),
                  if(product.hasStock)
                    Consumer2<UserManager,Product>(
                      builder: (_, userManager, product,__){
                        return SizedBox(height: 44,
                          child: RaisedButton(
                            onPressed: product.selectedSize != null ? (){
                              if(userManager.isLoggedIn){
                                context.read<CartManager>().addToCart(product);
                                Navigator.of(context).pushNamed('/cart');
                              }else{
                                Navigator.of(context).pushNamed('/login');
                              }
                            }: null,
                            color: primaryColor,
                            textColor: Colors.white,
                            child: Text(
                              userManager.isLoggedIn
                                  ? 'Adicionar ao carrinho'
                                  :'Entre para comprar',
                              style: const TextStyle(
                                fontSize: 18,
                              )
                               ),
                            ),
                        );
                      },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
