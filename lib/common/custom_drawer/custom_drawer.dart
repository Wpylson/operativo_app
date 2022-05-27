import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/custom_drawer/custom_drawer_header.dart';
import 'package:operativo_final_cliente/common/custom_drawer/drawer_tile.dart';
import 'package:operativo_final_cliente/models/user_manager.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // ignore: prefer_const_literals_to_create_immutables
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 203, 236, 241),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ListView(
            children: [
              CustomDrawerHeader(),
              const Divider(),
              const DrawerTile(
                iconData: Icons.home,
                title: 'Inicio',
                page: 0,
              ),
              const DrawerTile(
                iconData: Icons.list,
                title: 'Produtos',
                page: 1,
              ),
              const DrawerTile(
                iconData: Icons.playlist_add_check,
                title: 'Categorias',
                page: 2,
              ),
              const DrawerTile(
                iconData: Icons.playlist_add_check,
                title: 'Meus Pedidos',
                page: 3,
              ),
              const DrawerTile(
                iconData: Icons.location_on,
                title: 'Lojas',
                page: 4,
              ),
              Consumer<UserManager>(
                builder: (_, userManager, __) {
                  if (userManager.adminEnabled) {
                    return Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Divider(),
                        const DrawerTile(
                          iconData: Icons.settings,
                          title: 'Clientes',
                          page: 5,
                        ),
                        const DrawerTile(
                          iconData: Icons.settings,
                          title: 'Pedidos',
                          page: 6,
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
