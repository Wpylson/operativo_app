import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/custom_icon_button.dart';
import 'package:operativo_final_cliente/models/item_size.dart';

class EditItemSize extends StatelessWidget {

  const EditItemSize({Key key, this.size,this.onRemove,
    this.onMoveUp,this.onMoveDown}) : super(key: key);

  final ItemSize size;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.name,
            decoration: const InputDecoration(
              labelText: 'Titulo',
              isDense: true,
            ),
            validator: (name){
              if(name.isEmpty){
                return 'Iválido';
              }
              return null;
            },
            //Salvar o nome sempre aque haver mundanca
            onChanged: (name) => size.name = name,
          ),
        ),
        const SizedBox(width: 4,),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            decoration: const InputDecoration(
              labelText: 'Stock',
              isDense: true,
            ),
            keyboardType: TextInputType.number,
            validator: (stock){
              if(int.tryParse(stock) == null){
                return 'Iválido';
              }
              return null;
            },
            onChanged: (stock) => size.stock = int.tryParse(stock),
          ),
        ),
        const SizedBox(width: 4,),
       Expanded(
         flex: 40,
         child: TextFormField(
           initialValue: size.price?.toStringAsFixed(2),
           decoration: const InputDecoration(
             labelText: 'Preço',
             isDense: true,
             suffixText: 'Kz',
           ),
             keyboardType: const TextInputType.numberWithOptions(
                 decimal: true ),
           validator: (price){
             if(num.tryParse(price) == null){
               return 'Iválido';
             }
             return null;
           },
           onChanged: (price) => size.price = num.tryParse(price),
         ),
       ),
         CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
         CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
           onTap: onMoveUp,
        ),
         CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        )
      ],
    );
  }
}
