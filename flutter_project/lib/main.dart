import 'package:flutter/material.dart';


import 'authentication/signup.dart';
import 'package:flutter_complete_guide/authentication/type.dart';
import 'package:flutter_complete_guide/authentication/signup_profile.dart';
import 'authentication/login.dart';
import 'mainscreen.dart';
import 'package:flutter_complete_guide/user/mainpage.dart';

// import 'package:flutter_complete_guide/payment/creditcard.dart';
// import 'package:flutter_complete_guide/payment/mbway.dart';
// import 'package:flutter_complete_guide/payment/paymentOptions.dart';
// import 'package:flutter_complete_guide/payment/paymentprocessor.dart';
// import 'package:flutter_complete_guide/payment/paypal.dart';
// import 'package:flutter_complete_guide/user/chatRoom.dart';

// import 'package:flutter_complete_guide/user/createConcert.dart';
// import 'package:flutter_complete_guide/user/concertInfo.dart';
// import 'package:flutter_complete_guide/user/concertStream.dart';
// import 'package:flutter_complete_guide/user/voicecall.dart';
// import 'package:flutter_complete_guide/user/userProfile.dart';
// import 'package:flutter_complete_guide/user/editUserProfile.dart';


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
        // "/payment": (context) => PaymentOptions(),
        // "/payment/creditcard": (context) => CreditCardOption(),
        // "/payment/paypal": (context) => PaypalOption(),
        // "/payment/mbway": (context) => MBWayOption(),
        // "/payment/process": (context) => PaymentProcessor(),
        "/user/main": (context) => UserMainPage(),
        // "/user/concertCreate": (context) => CreateConcert(),
        // "/user/concertInfo": (context) => ConcertInfoPage(),
        // "/user/concertStream": (context) => ConcertStream(),
        // "/user/userProfile": (context) => UserProfile(),
        // "/user/editProfile": (context) => EditUserProfile(),
        // "/user/voicecall": (context) => VoiceCall(),
        // "/user/userchat": (context) => ChatRoom(),
      },
    );
  }
}