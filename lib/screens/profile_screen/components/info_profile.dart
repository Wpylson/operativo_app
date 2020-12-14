import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:operativo_final_cliente/common/constants.dart';
import 'package:operativo_final_cliente/common/list_item_widget.dart';


class InfoProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: kSpacingUnit.w *10,
            width: kSpacingUnit.w *10,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: kSpacingUnit.w *5,
                  backgroundImage: const AssetImage('assets/images/profile.jpg'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w*3,
                    width: kSpacingUnit.w*3,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        shape: BoxShape.circle
                    ),
                    child: IconButton(
                      icon: const Icon(LineAwesomeIcons.pen),
                      color: kDarkPrimaryColor,
                      iconSize: ScreenUtil().setSp(kSpacingUnit.w *1.5),
                      onPressed: (){},
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2,),
          Text('Walter Cabral', style: kTitleTextStyle),
          SizedBox(height: kSpacingUnit.w * 0.5,),
          Text('waltercabral@gmail.com', style: kCaptionTextStyle),
          SizedBox(height: kSpacingUnit.w * 2,),
          Container(
            height: kSpacingUnit.w * 4,
            width: kSpacingUnit.w * 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                color: Theme.of(context).accentColor
            ),
            child: Center(
              child: Text('Cliente VIP', style: kButtonTextStyle,),
            ),
          ),
        ],
      ),
    );
  }
}
