import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/circle_button.dart';
import 'package:operativo_final_cliente/screens/products/products_screen.dart';
import 'package:operativo_final_cliente/screens/profile_screen/profile_screen.dart';

class HomeBaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget bigCircle =  Container(
      width: 400.0,
      height: 400.0,
      decoration:
      const BoxDecoration(color: Colors.yellowAccent, shape: BoxShape.circle),
    );

    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: TextButton(
            onPressed: (){},
            child: const Icon(Icons.menu)
        ),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute( builder: (context)=>ProfileScreen()));
              },
              child: const Icon(Icons.shopping_cart)
          ),
          TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute( builder: (context)=>ProfileScreen()));
              },
              child: const Icon(Icons.person)
          ),
        ],
      ),
      body: Material(
        color: Colors.white,
        child: ListView(
          children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               // ignore: prefer_const_literals_to_create_immutables
               children: [
                   const Text(
                    'Operativo',
                    style: TextStyle(
                      fontSize: 38,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   children: [
                     TextButton(
                         onPressed: (){
                           Navigator.push(context, MaterialPageRoute( builder: (context)=>ProfileScreen()));
                         },
                         child: const Icon(Icons.shopping_cart)
                     ),
                     TextButton(
                         onPressed: (){
                           Navigator.push(context, MaterialPageRoute( builder: (context)=>ProfileScreen()));
                         },
                         child: const Icon(Icons.person)
                     ),
                   ],
                 ),

               ],
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
                      child:  CircleButton(onTap: () => print("Cool"), iconData: Icons.store_mall_directory,menu: 'Lojas'),
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
