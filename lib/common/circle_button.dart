import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/colors.dart';

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;
  final String menu;
  const CircleButton({Key key,this.onTap,this.iconData,this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const double size = 110.0;
    return InkResponse(
      onTap: onTap,
      child:  Container(
        width: size,
          height: size,
        decoration:  BoxDecoration(
          color: azul,
          shape: BoxShape.circle,
          border:  Border.all(color: amarela,width: 2.0),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(
                  iconData,
                  color: amarela,
                  size: 50,
                ),
                const SizedBox(height: 15,),
                Text(menu,
                style:  TextStyle(
                  color:branco,
                  fontSize: 14,
                ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
