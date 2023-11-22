import 'package:firebase_core/firebase_core.dart';
import 'package:firebasedemo/ButtomNavigationbarPages/page1.dart';

import 'package:firebasedemo/Service/Auth_Service.dart';
import 'package:firebasedemo/pages/HomePage.dart';

import 'package:firebasedemo/pages/LogIn.dart';
import 'package:firebasedemo/pages/SignUpPage.dart';
import 'package:firebasedemo/pages/signupscreen1.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = const SignUpPage();
  AuthClass authClass = AuthClass();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    debugPrint(token);
    if (token != null) {
      setState(() {
        currentPage = const HomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckScreen(), //Checkscreen
    );
  }
}
