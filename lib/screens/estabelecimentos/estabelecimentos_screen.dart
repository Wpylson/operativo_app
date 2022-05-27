import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/colors.dart';
import 'package:operativo_final_cliente/models/estabelecimentos_manager.dart';
import 'package:operativo_final_cliente/screens/base/base_screen.dart';
import 'package:operativo_final_cliente/screens/base/home_base_screen.dart';
import 'package:operativo_final_cliente/screens/estabelecimentos/components/estab_list_tile.dart';
import 'package:provider/provider.dart';

class EstabelecimentosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: azul,
      appBar: AppBar(
        title: Text(
          'Estabelecimentos',
          style: TextStyle(color: amarela),
        ),
        backgroundColor: azul,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: amarela,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeBaseScreen()));
            }),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: amarela,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Consumer<EstabelecimentosManager>(
        builder: (_, estabManager, __) {
          final filteredEstab = estabManager.filteredEstabs;
          if (filteredEstab.isNotEmpty) {
            return ListView.builder(
              itemCount: filteredEstab.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: EstabListTile(
                    filteredEstab[index],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'Sem estabelecimentos!',
                style: TextStyle(fontSize: 22.0, color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
