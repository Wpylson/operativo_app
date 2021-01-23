import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/circle_button.dart';
import 'package:operativo_final_cliente/screens/cart/cart_screen.dart';
import 'package:operativo_final_cliente/screens/estabelecimentos/estabelecimentos_screen.dart';
import 'package:operativo_final_cliente/screens/products/category_screen.dart';
import 'package:operativo_final_cliente/screens/products/products_screen.dart';
import 'package:operativo_final_cliente/screens/profile_screen/profile_screen.dart';

class HomeBaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget bigCircle =  Container(
      width: 400.0,
      height: 400.0,
      decoration:
       BoxDecoration(color: Colors.indigo[900], shape: BoxShape.circle),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        leading: TextButton(
            onPressed: (){},
            child: const Icon(Icons.menu,color: Colors.yellow)
        ),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute( builder: (context)=>CartScreen()));
              },
              child: const Icon(Icons.shopping_cart,color: Colors.yellow)
          ),
          TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute( builder: (context)=>ProfileScreen()));
              },
              child: const Icon(Icons.person, color: Colors.yellow,)
          ),
        ],
      ),
      body: Material(
        color: Colors.indigo[900],
        child: ListView(
          children: [
           const Padding(
             padding:  EdgeInsets.all(8.0),
             child:  Text(
              'Operativo',
              style: TextStyle(
                fontSize: 38,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
                  ),
           ),
            const SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Stack(
                  children: [
                    bigCircle,
                    Positioned(
                      top: 10.0,
                      left: 135.0,
                      child: CircleButton(
                        onTap: () => print("Cool"), iconData: Icons.favorite_border,menu: 'Nao gosto',),
                    ),
                    Positioned(
                      top: 140.0,
                      left: 0.0,
                      child: CircleButton(
                          onTap: () => print("Cool"), iconData: Icons.favorite,menu: 'Favoritos'),
                    ),
                    Positioned(
                      top: 140.0,
                      right: 0.0,
                      child:  CircleButton(onTap: () {
                        Navigator.push(context, MaterialPageRoute( builder: (context)=>EstabelecimentosScreen()));
                      },
                          iconData: Icons.store_mall_directory,menu: 'Lojas'),
                    ),
                    Positioned(
                      top: 280.0,
                      left: 135.0,
                      child:  CircleButton(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute( builder: (context)=>ProductsScreen()));
                          },
                          iconData: Icons.local_pizza,menu: 'Pizzarias'),
                    ),
                    Positioned(
                      top: 145.0,
                      left: 135.0,
                      child:  CircleButton(onTap: () => print("Cool"), iconData: Icons.satellite,menu: 'Favoritos'),
                    ),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
