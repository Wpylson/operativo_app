import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/circle_button.dart';
import 'package:operativo_final_cliente/common/colors.dart';
import 'package:operativo_final_cliente/screens/cart/cart_screen.dart';
import 'package:operativo_final_cliente/screens/estabelecimentos/estabelecimentos_screen.dart';
import 'package:operativo_final_cliente/screens/products/products_screen.dart';
import 'package:operativo_final_cliente/screens/profile_screen/profile_screen.dart';

class HomeBaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Widget bigCircle = Container(
      width: 400.0,
      height: 400.0,
      decoration: BoxDecoration(color: azul, shape: BoxShape.circle),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: azul,
        leading: TextButton(
            onPressed: () {}, child: Icon(Icons.menu, color: amarela)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              icon: Icon(Icons.shopping_bag_outlined, color: amarela)),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            icon: Icon(Icons.person, color: amarela),
          ),
        ],
      ),
      body: Material(
        color: azul,
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo2.png',
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Stack(
                  children: [
                    bigCircle,
                    Positioned(
                      top: 10.0,
                      left: 130.0,
                      child: CircleButton(
                        onTap: () => print("Cool"),
                        iconData: Icons.favorite_border,
                        menu: 'Nao gosto',
                      ),
                    ),
                    Positioned(
                      top: 140.0,
                      left: 0.0,
                      child: CircleButton(
                          onTap: () => print("Cool"),
                          iconData: Icons.favorite,
                          menu: 'Favoritos'),
                    ),
                    Positioned(
                      top: 140.0,
                      right: 0.0,
                      child: CircleButton(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EstabelecimentosScreen()));
                          },
                          iconData: Icons.store_mall_directory,
                          menu: 'Lojas'),
                    ),
                    Positioned(
                      top: 280.0,
                      left: 130.0,
                      child: CircleButton(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductsScreen()));
                          },
                          iconData: Icons.local_pizza,
                          menu: 'Pizzarias'),
                    ),
                    Positioned(
                      top: 145.0,
                      left: 128.0,
                      child: CircleButton(
                          onTap: () => Navigator.of(context).pushNamed('/anything'),
                          iconData: Icons.satellite,
                          menu: 'Qualquer \n  Coisa',
                      heightSized: 10,),
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
