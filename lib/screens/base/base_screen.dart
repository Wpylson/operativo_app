import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:operativo_final_cliente/screens/home/home_screen.dart';
import 'package:operativo_final_cliente/screens/menu/menu_screen.dart';
import 'package:operativo_final_cliente/screens/products/category_screen.dart';
import 'package:operativo_final_cliente/screens/products/products_screen.dart';
import 'package:operativo_final_cliente/screens/profile_screen/profile_screen.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController _pageController = PageController();

  int _page = 0;

//Deixar o app sempre na vertical
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _page = 0;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.teal,
            primaryColor: Colors.white,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: const TextStyle(color: Colors.white54))),
        child: BottomNavigationBar(
          currentIndex: _page,
          onTap: (p) {
            _pageController.animateToPage(p,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.home),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.search),
              label: 'Pesquisar',
            ),
            BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.angellist),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.list),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(LineAwesomeIcons.user_1),
              label: 'Eu',
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (p) {
          setState(() {
            _page = p;
          });
        },
        children: [
          HomeScreen(),
          ProductsScreen(),
          CategoryScreen(),
          MenuScreen(),
          ProfileScreen()
        ],
      ),
    );
  }
}
