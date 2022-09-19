import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_flutter/reusable_widget/reusable_widgets.dart';
import 'package:money_manager_flutter/screens/home/screen_home.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final _userNameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple, Colors.red],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(children: [
              reusableTextField("Enter User Name", Icons.person_outline, false,
                  _userNameTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Email Id", Icons.person_outline, false,
                  _emailTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Enter Password", Icons.lock_outlined, true,
                  _passwordTextController),
              const SizedBox(
                height: 20,
              ),
              firebaseButton(context, "Sign Up", () async {
                // log( _emailTextController.text);
                // log(_passwordTextController.text);
                await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                  log("Created New Account");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ScreenHome()),
                  );
                }).onError((error, stackTrace) {
                  log("Error ${error.toString()}");
                   ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Email or password doesn't exist"),
                  ),
                );
                });
              }),
            ]),
          ),
        ),
      ),
    );
  }
}
