import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:operativo_final_cliente/common/constants.dart';
import 'package:operativo_final_cliente/common/list_item_widget.dart';
import 'package:operativo_final_cliente/screens/profile_screen/components/header_profile.dart';
import 'package:operativo_final_cliente/screens/profile_screen/components/info_profile.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,allowFontScaling: true,designSize: const Size(414,896));

    return  Scaffold(
      body: Column(
        children: [
          SizedBox(height: kSpacingUnit.w * 5,),
          InfoProfile(),
          Expanded(
            child: ListView(
              children: [
                const ListItemWidget(
                  icon: LineAwesomeIcons.heart_1,
                  text: 'Favoritos',
                  hasNavigation: true,
                ),
                const ListItemWidget(
                  icon: LineAwesomeIcons.alternate_list,
                  text: 'Meus Pedidos',
                  hasNavigation: true,
                ),
                const ListItemWidget(
                  icon: LineAwesomeIcons.history,
                  text: 'Histórico',
                  hasNavigation: true,
                ),
                ListItemWidget(
                  icon: LineAwesomeIcons.alternate_sign_out,
                  text: 'Sair',
                  hasNavigation: false,
                  tap: (){

                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}

