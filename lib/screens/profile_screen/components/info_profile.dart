import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:operativo_final_cliente/common/constants.dart';
import 'package:operativo_final_cliente/common/list_item_widget.dart';
import 'package:operativo_final_cliente/models/user_manager.dart';
import 'package:provider/provider.dart';


class InfoProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<UserManager>(
          builder:(_,userManager,__){
          return Column(
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
            Text('Olá, ${userManager.user?.name?? 'Incia Sessão ou cria uma nova conta '}', style: kTitleTextStyle),
            SizedBox(height: kSpacingUnit.w * 0.5,),
            Text(userManager.user.email, style: kCaptionTextStyle),
            ],
          );
        }
        ),

      ],
    );
  }
}
