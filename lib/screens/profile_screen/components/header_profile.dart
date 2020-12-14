import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:operativo_final_cliente/common/constants.dart';
import 'package:operativo_final_cliente/screens/profile_screen/components/info_profile.dart';

class HeaderProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: kSpacingUnit.w*3,),
        InfoProfile(),

        SizedBox(height: kSpacingUnit.w * 3,),
      ],
    );
  }
}
