import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:operativo_final_cliente/common/custom_drawer/custom_drawer.dart';import 'package:operativo_final_cliente/models/page_manager.dart';
import 'package:operativo_final_cliente/models/user_manager.dart';
import 'package:operativo_final_cliente/screens/admin_orders/admin_orders_screen.dart';
import 'package:operativo_final_cliente/screens/admin_users/admin_users_screen.dart';
import 'package:operativo_final_cliente/screens/home/home_screen.dart';
import 'package:operativo_final_cliente/screens/orders/orders_screen.dart';
import 'package:operativo_final_cliente/screens/products/category_screen.dart';
import 'package:operativo_final_cliente/screens/products/products_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

//Deixar o app sempre na vertical
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_,userManager,__){
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              ProductsScreen(),
              CategoryScreen(),
              OrdersScreen(),
              Scaffold(
                drawer: CustomDrawer(),
                appBar: AppBar(
                  title: const Text('Lojas'),
                ),
              ),
              if(userManager.adminEnabled)
                ...[
                 AdminUsersScreen(),
                  AdminOrdersScreen(),
                ]
            ],
          );
        },
      ),
    );
  }
}
