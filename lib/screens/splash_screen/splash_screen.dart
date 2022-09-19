import 'package:flutter/material.dart';
import 'package:money_manager_flutter/screens/sign_in_screen/sign_in_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(context);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: const BoxDecoration(color: Colors.blue),
        child: Image.asset(
          "assets/images/image.png",
          height: 600,
        ),
      ),
    );
  }

  log(context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignInScreen()));
  }
}
