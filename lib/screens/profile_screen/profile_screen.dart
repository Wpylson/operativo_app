import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:operativo_final_cliente/common/constants.dart';
import 'package:operativo_final_cliente/common/list_item_widget.dart';
import 'package:operativo_final_cliente/models/user_manager.dart';
import 'package:operativo_final_cliente/screens/profile_screen/components/header_profile.dart';
import 'package:operativo_final_cliente/screens/profile_screen/components/info_profile.dart';
import 'package:provider/provider.dart';
import 'package:operativo_final_cliente/models/user_manager.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        allowFontScaling: true, designSize: const Size(414, 896));
    return Scaffold(body: Consumer<UserManager>(builder: (_, userManager, __) {
      if (userManager.isLoggedIn) {
        return Column(
          children: [
            SizedBox(
              height: kSpacingUnit.w * 5,
            ),
            Column(
              children: [
                Consumer<UserManager>(builder: (_, userManager, __) {
                  return Column(
                    children: [
                      SizedBox(
                        height: kSpacingUnit.w * 10,
                        width: kSpacingUnit.w * 10,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: kSpacingUnit.w * 5,
                              backgroundImage:
                                  const AssetImage('assets/images/profile.jpg'),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height: kSpacingUnit.w * 3,
                                width: kSpacingUnit.w * 3,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
                                    shape: BoxShape.circle),
                                child: IconButton(
                                  icon: const Icon(LineAwesomeIcons.pen),
                                  color: kDarkPrimaryColor,
                                  iconSize:
                                      ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: kSpacingUnit.w * 2,
                      ),
                      Text(
                          'Olá, ${userManager.user?.name ?? 'Incia Sessão ou cria uma nova conta '}',
                          style: kTitleTextStyle),
                      SizedBox(
                        height: kSpacingUnit.w * 0.5,
                      ),
                      Text(userManager.user.email, style: kCaptionTextStyle),
                    ],
                  );
                }),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  const ListItemWidget(
                    icon: LineAwesomeIcons.heart_1,
                    text: 'Favoritos',
                    hasNavigation: true,
                  ),
                   ListItemWidget(
                    icon: LineAwesomeIcons.alternate_list,
                    text: 'Meus Pedidos',
                    hasNavigation: true,
                    tap: (){
                      Navigator.of(context).pushNamed('/orders');
                    },
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
                        tap: () {
                          userManager.signOut();
                        },
                      ),

                ],
              ),
            )
          ],
        );
      } else {
        return Center(
          child: ListItemWidget(
            icon: LineAwesomeIcons.door_open,
            text: 'Iniciar Sessão ou Criar Conta',
            hasNavigation: true,
            tap: () {
              Navigator.of(context).pushNamed('/login');
            },
          ),
        );
      }
    }));
  }
}
