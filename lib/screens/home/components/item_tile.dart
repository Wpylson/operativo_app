import 'dart:io';
import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/home_manager.dart';
import 'package:operativo_final_cliente/models/product.dart';
import 'package:operativo_final_cliente/models/product_manger.dart';
import 'package:operativo_final_cliente/models/section.dart';
import 'package:operativo_final_cliente/models/section_item.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(this.item);
  final SectionItem item;
  @override
  Widget build(BuildContext context) {

    final homeManager = context.watch<HomeManager>();

    return GestureDetector(
        onTap: () {
          if (item.product != null) {
            final product =
                context.read<ProductManager>().findProductByID(item.product);
            if (product != null) {
              Navigator.of(context).pushNamed('/product', arguments: product);
            }
          }
        },
        onLongPress: homeManager.editing ? (){
          showDialog(
              context: context,
            builder: (_){
                //Pegar o produto vinculado com a imagem
              final product = context.read<ProductManager>()
              .findProductByID(item.product);
                return AlertDialog(
                  title:const Text('Editar Item'),
                  content: product != null
                      ? ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Image.network(product.images.first),
                          title: Text(product.name),
                          subtitle: Text('${product.basePrice.toStringAsFixed(2)} Kz'),
                        )
                      :const Text('Imagem não esta vinculada'),
                  actions: [
                    FlatButton(
                      onPressed: (){
                        context.read<Section>().removeItem(item);
                        Navigator.of(context).pop();
                      },
                      textColor: Colors.red,
                      child: const Text('Excluir'),
                    ),
                    FlatButton(
                        onPressed: ()async{
                          if(product != null){
                            item.product = null;
                          }
                          else{
                            final Product product = await Navigator.of(context).pushNamed('/select_product') as Product;
                            item.product = product?.id;
                          }
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          product != null
                              ? 'Desvincular'
                              : 'Vincular'
                        )
                    )
                  ],
                );
            }
          );
        }:null,
        child: AspectRatio(
            aspectRatio: 1,
            child: item.image is String
            ? FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: item.image as String,
              fit: BoxFit.cover,
            )
        : Image.file(item.image as File, fit: BoxFit.cover,),
        )
    );
  }
}
