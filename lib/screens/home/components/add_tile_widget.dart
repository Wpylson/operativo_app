import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/models/section.dart';
import 'package:operativo_final_cliente/models/section_item.dart';
import 'package:operativo_final_cliente/screens/edit_product/componets/image_source_sheet.dart';
import 'package:provider/provider.dart';
class AddTileWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final section = context.watch<Section>();

    void onImageSelected(File file){
      section.addItem(SectionItem(image: file));
      Navigator.of(context).pop();
    }

    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: (){
          if (Platform.isAndroid) {
            showModalBottomSheet(
                context: context,
                builder: (_) => ImageSourceSheet(
                  onImageSelected:onImageSelected ,
                )
            );
          } else {
            showCupertinoModalPopup(
                context: context,
                builder: (_) => ImageSourceSheet(
                  onImageSelected: onImageSelected,
                )
            );
          }
        },
        child: Container(
          color: Colors.white.withAlpha(30),
          child: const Icon(Icons.add,
          color: Colors.white,
          ),
        ),
      ),
    );
  }
}
