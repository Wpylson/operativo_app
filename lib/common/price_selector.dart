import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/colors.dart';

class PriceSelector extends StatefulWidget {

  @override
  _PriceSelectorState createState() => _PriceSelectorState();
}

class _PriceSelectorState extends State<PriceSelector> {
  @override
  Widget build(BuildContext context) {

    int selected;
    Color color;
    if(selected == 1){
      color = azul;
    }
    else{
      color = grey;
    }

    return InkWell(
      onTap: (){
        setState(() {
          selected =1;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: color,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                ' 1000Kz \n     e \n5000kz',
                style: TextStyle(
                  color: color,
                  fontSize: 12.0
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
