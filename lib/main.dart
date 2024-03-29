import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/admin_orders_manager.dart';
import 'package:operativo_final_cliente/models/admin_users_manager.dart';
import 'package:operativo_final_cliente/models/cart_manager.dart';
import 'package:operativo_final_cliente/models/category_manager.dart';
import 'package:operativo_final_cliente/models/categorys.dart';
import 'package:operativo_final_cliente/models/estabelecimentos_manager.dart';
import 'package:operativo_final_cliente/models/home_manager.dart';
import 'package:operativo_final_cliente/models/orders_manager.dart';
import 'package:operativo_final_cliente/models/product.dart';
import 'package:operativo_final_cliente/models/product_manger.dart';
import 'package:operativo_final_cliente/models/services.dart';
import 'package:operativo_final_cliente/models/services_manager.dart';
import 'package:operativo_final_cliente/models/user_manager.dart';
import 'package:operativo_final_cliente/screens/address/address_screen.dart';
import 'package:operativo_final_cliente/screens/anything/anything_screen.dart';
import 'package:operativo_final_cliente/screens/anything/checkout_anything_screen.dart';
import 'package:operativo_final_cliente/screens/base/home_base_screen.dart';
import 'package:operativo_final_cliente/screens/cart/cart_screen.dart';
import 'package:operativo_final_cliente/screens/checkout/checkout_screen.dart';
import 'package:operativo_final_cliente/screens/confirmations/confirmation_screen.dart';
import 'package:operativo_final_cliente/screens/edit_product/edit_product_screen.dart';
import 'package:operativo_final_cliente/screens/login/login_screen.dart';
import 'package:operativo_final_cliente/screens/menu/menu_screen.dart';
import 'package:operativo_final_cliente/screens/menu/service_screen_list.dart';
import 'package:operativo_final_cliente/screens/orders/orders_screen.dart';
import 'package:operativo_final_cliente/screens/product/product_screen.dart';
import 'package:operativo_final_cliente/screens/products/product_screen_list.dart';
import 'package:operativo_final_cliente/screens/select_product/select_product_screen.dart';
import 'package:operativo_final_cliente/screens/signup/signup_screen.dart';
import 'package:operativo_final_cliente/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(MyApp());
  //01001000
  //13087000
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          //para poder trazer o cart list do user logado
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          //para poder trazer os pedidos do user logado
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) =>
              ordersManager..updateUser(userManager.user),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ServiceManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => EstabelecimentosManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUserManager) =>
              adminUserManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
          create: (_) => AdminOrdersManager(),
          lazy: false,
          update: (_, userManager, adminOrdersManager) => adminOrdersManager
            ..updateAdmin(adminEnabled: userManager.adminEnabled),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: const AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        //initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case '/product':
              return MaterialPageRoute(
                builder: (_) => ProductScreen(settings.arguments as Product),
              );
            case '/category':
              return MaterialPageRoute(
                builder: (_) =>
                    ProductScreenList(settings.arguments as Category),
              );
            case '/cart':
              return MaterialPageRoute(
                builder: (_) => CartScreen(),
                settings: settings,
              );
            case '/edit_product':
              return MaterialPageRoute(
                builder: (_) =>
                    EditProductScreen(settings.arguments as Product),
              );
            case '/services':
              return MaterialPageRoute(
                builder: (_) =>
                    ServiceScreenList(settings.arguments as Services),
              );
            case '/select_product':
              return MaterialPageRoute(builder: (_) => SelectProductScreen());
            case '/address':
              return MaterialPageRoute(builder: (_) => AddressScreen());
            case '/checkout':
              return MaterialPageRoute(builder: (_) => CheckoutScreen());
            case '/orders':
              return MaterialPageRoute(builder: (_) => OrdersScreen());
            case '/menu':
              return MaterialPageRoute(builder: (_) => MenuScreen());
            case '/confirmation':
              return MaterialPageRoute(
                builder: (_) => ConfirmationScreen(settings.arguments as Order),
              );
            case '/anything':
              return MaterialPageRoute(builder: (_) => AnythingScreen());
            case '/checkout_anything':
              return MaterialPageRoute(
                builder: (_) => CheckoutAnythingScreen(),
              );
            case '/base':
              //default:
              return MaterialPageRoute(
                builder: (_) => HomeBaseScreen(),
              );
            case '/':
            default:
              return MaterialPageRoute(
                builder: (_) => SplashScreen(),
                settings: settings,
              );
          }
        },
      ),
    );
  }
}
