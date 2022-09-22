import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_flutter/reusable_widget/reusable_widgets.dart';
import 'package:money_manager_flutter/screens/home/screen_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple, Colors.red])),
        child: Padding(
          padding: EdgeInsets.only(top: size.height * 0.2, left: 10, right: 10),
          child: Column(children: [
            reusableTextField("Enter Email", Icons.person_outline, false,
                _emailTextController),
            const SizedBox(
              height: 20,
            ),
            reusableTextField("Enter Password", Icons.lock_outline, true,
                _passwordTextController),
            forgetPassword(context),
            firebaseButton(context, 'Sign In', () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('email', 'useremail@gmail.com');
              await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                  .then((value) {
                log("Sign In");
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const ScreenHome()),
                    (route) => false);
              }).onError((error, stackTrace) {
                log("Error ${error.toString()}");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Email and password doesn't match"),
                  ),
                );
              });
            }),
            const SizedBox(
              height: 20,
            ),
            signUpOption(context),
          ]),
        ),
      ),
    );
  }
}
