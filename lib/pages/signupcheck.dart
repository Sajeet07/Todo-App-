import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/pages/HomePage.dart';
import 'package:firebasedemo/pages/LogIn.dart';
import 'package:flutter/material.dart';

class SignupCheck {
  void signupCheck(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      Timer(
        const Duration(seconds: 1),
        () => Navigator.pushReplacement(
          (context),
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        ),
      );
    } else {
      Timer(
        const Duration(seconds: 1),
        () => Navigator.pushReplacement(
          (context),
          MaterialPageRoute(
            builder: (context) => const LogInPage(),
          ),
        ),
      );
    }
  }
}
