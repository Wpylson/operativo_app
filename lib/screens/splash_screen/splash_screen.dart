import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:operativo_final_cliente/common/colors.dart';
import 'package:operativo_final_cliente/models/user_manager.dart';
import 'package:operativo_final_cliente/screens/base/home_base_screen.dart';
import 'package:operativo_final_cliente/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserManager userManager;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeBaseScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: azul,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo1.png',
              height: 100.0,
              width: 100.0,
            ),
            const SizedBox(
              height: 10.0,
            ),
            const CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation(Color.fromRGBO(255, 207, 1, 1.0)),
            )
          ],
        ),
      ),
    );
  }
}
