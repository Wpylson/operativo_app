import 'package:flutter/material.dart';

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
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(
                  iconData,
                  color: Colors.black,
                  size: 50,
                ),
                const SizedBox(height: 20,),
                Text(menu,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
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
