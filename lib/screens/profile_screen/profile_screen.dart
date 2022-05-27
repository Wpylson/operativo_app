import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:operativo_final_cliente/common/colors.dart';
import 'package:operativo_final_cliente/common/constants.dart';
import 'package:operativo_final_cliente/common/list_item_widget.dart';
import 'package:operativo_final_cliente/models/user_manager.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      minTextAdapt: true,
      designSize: const Size(414, 896),
    );
    return Scaffold(
        backgroundColor: azul,
        appBar: AppBar(
          backgroundColor: azul,
          elevation: 0,
        ),
        body: Consumer<UserManager>(builder: (_, userManager, __) {
          if (userManager.isLoggedIn) {
            return Column(
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: kSpacingUnit.w * 10,
                          width: kSpacingUnit.w * 10,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: kSpacingUnit.w * 5,
                                backgroundImage: const AssetImage(
                                    'assets/images/profile.jpg'),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: kSpacingUnit.w * 3,
                                  width: kSpacingUnit.w * 3,
                                  decoration: BoxDecoration(
                                    color: amarela,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      LineAwesomeIcons.pen,
                                      color: azul,
                                    ),
                                    color: azul,
                                    iconSize: ScreenUtil()
                                        .setSp(kSpacingUnit.w * 1.5),
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
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: kSpacingUnit.w * 0.5,
                        ),
                        Text(
                          userManager.user.email,
                          style: TextStyle(
                            fontSize: 12,
                            color: branco,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: kSpacingUnit.w * 2,
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
                        tap: () {
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
                      ListItemWidget(
                        icon: LineAwesomeIcons.helping_hands,
                        text: 'Ajuda',
                        hasNavigation: true,
                        tap: () {},
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
