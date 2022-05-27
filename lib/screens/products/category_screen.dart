import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/category_manager.dart';
import 'package:provider/provider.dart';
import 'componets/category_tile.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categorias',
        ),
        centerTitle: true,
      ),
      body: Consumer<CategoryManager>(
        builder: (_, catMan, __) {
          final filteredCategorys = catMan.filteredCategorys;
          if (filteredCategorys.isNotEmpty) {
            return ListView.builder(
              itemCount: filteredCategorys.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: CategoryTile(filteredCategorys[index]),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'Categoria nao encontrada!',
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
