import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/item_size.dart';
import 'package:operativo_final_cliente/models/product.dart';
import 'package:provider/provider.dart';

class SizeWidget extends StatelessWidget {
  const SizeWidget({this.size});
  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<Product>(); //usar o contexto actual, nesse casso um produto especifico
    final selected = size == product.selectedSize;

    Color color;
    if(!size.hasStock){
      color = Colors.red.withAlpha(50);
    }else if(selected){
      color = Theme.of(context).primaryColor;
    }else{
      color = Colors.grey;
    }

    return GestureDetector(
      onTap: (){
        if(size.hasStock){
          product.selectedSize = size;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: color,
              padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
              child: Text(
                size.name,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
               ' ${size.price.toStringAsFixed(2)} Kz',
                style: TextStyle(
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
