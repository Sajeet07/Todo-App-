// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClass {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = const FlutterSecureStorage();
  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn
          .signIn(); //it will open the pop up for multiple gmail options
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount
                .authentication; //this if block will get the details of your google sign in

        AuthCredential credential = GoogleAuthProvider.credential(
          /*credential will give your the gmail credential*/
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        try {
          UserCredential userCredential = await auth.signInWithCredential(
              credential); //passing parameter(credential)will be used to signin with firebase
          storeTokenAndData(
              userCredential); //calling this method before navigating to next screen and passing userCredential which we are getting after the sign in with the credential with firebase.
          //It will be going to store the token in flutter_secure_storage and we have to check that  token in main.dart file.
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (builder) => const HomePage()));
        } catch (e) {
          final snackBar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        final snackBar = SnackBar(content: Text('Not able to sign in'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> storeTokenAndData(UserCredential userCredential) async {
    debugPrint(userCredential.credential?.token.toString());
    await storage.write(
        key: "token", value: userCredential.credential?.token.toString());
    //in value:--- this is how we get token and token is int type so we should convert in to string because value parameter always take string as a parameter
    debugPrint(userCredential.credential?.token.toString());
    await storage.write(
        key: "userCredential", value: userCredential.toString());
  }

  //checking token
  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }
}
