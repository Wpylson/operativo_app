import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/categorys.dart';

class ProductScreenList extends StatelessWidget {
  final Category category;
  const ProductScreenList(this.category);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(category.title),
        centerTitle: true,
      ),

    );
  }
}
