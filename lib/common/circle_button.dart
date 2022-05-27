import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/colors.dart';

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;
  final String menu;
  final double fontSize;
  final double heightSized;
  const CircleButton({Key key,this.onTap,this.iconData,this.menu, this.fontSize, this.heightSized}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    const double size = 120.0;
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
                 SizedBox(height: heightSized,),
                Text(menu,
                style:  TextStyle(
                  color:branco,
                  fontSize: fontSize,
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
