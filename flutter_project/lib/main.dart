import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/authentication/type.dart';
import 'package:flutter_complete_guide/authentication/signup_profile.dart';


import 'authentication/login.dart';
import 'authentication/signup.dart';
import 'mainscreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {   
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MainPage(), //   <-- screen1
      ),
      initialRoute: "/",
      routes: {
        "/login": (context) => Login(),
        "/signup": (context) => SignUp(),
        "/signup/type": (context) => SignUpType(),
        "/signup/profile": (context) => SignUpProfile(),
      },
    );
  }
}
