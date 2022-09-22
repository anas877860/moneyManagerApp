import 'package:flutter/material.dart';
import 'package:money_manager_flutter/screens/home/screen_home.dart';
import 'package:money_manager_flutter/screens/sign_in_screen/sign_in_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkLogIn(context);

    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: Image.asset(
            "assets/images/pocket_logo.jpg",
          ),
        ),
      ),
    );
  }

  goToLogin(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    if (email == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ScreenHome()));
    }
  }

  checkLogIn(context) async {
    await Future.delayed(const Duration(seconds: 3));
    goToLogin(context);
  }
}
