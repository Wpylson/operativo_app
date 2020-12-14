import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:operativo_final_cliente/common/constants.dart';

class ListItemWidget extends StatelessWidget {

  final IconData icon;
  final String text;
  final bool hasNavigation ;
  final VoidCallback tap;
  const ListItemWidget({Key key,this.icon,this.text,this.hasNavigation=true,this.tap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        height: kSpacingUnit.w * 5.5,
        margin: EdgeInsets.symmetric(
          horizontal: kSpacingUnit.w * 4,
        ).copyWith(bottom: kSpacingUnit.w * 2),
        padding: EdgeInsets.symmetric( horizontal: kSpacingUnit.w * 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
            color: Theme.of(context).backgroundColor
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size:kSpacingUnit.w * 2.5,
            ),
            SizedBox(width: kSpacingUnit.w * 2.5,),
            Text(
              text,
              style: kTitleTextStyle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            if (hasNavigation)
              Icon(
                LineAwesomeIcons.angle_right,
                size: kSpacingUnit.w * 2.5,
              ),
          ],
        ),
      ),
    );
  }
}