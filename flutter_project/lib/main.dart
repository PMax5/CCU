import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/authentication/type.dart';
import 'package:flutter_complete_guide/payment/creditcard.dart';
import 'package:flutter_complete_guide/payment/mbway.dart';
import 'package:flutter_complete_guide/payment/paymentOptions.dart';
import 'package:flutter_complete_guide/payment/paymentprocessor.dart';
import 'package:flutter_complete_guide/payment/paypal.dart';
import 'package:flutter_complete_guide/user/mainpage.dart';
import 'package:flutter_complete_guide/user/concertInfo.dart';

import 'authentication/login.dart';
import 'authentication/signup.dart';
import 'mainscreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {   //ctrl + shift + R (refactor)
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
        "/payment": (context) => PaymentOptions(),
        "/payment/creditcard": (context) => CreditCardOption(),
        "/payment/paypal": (context) => PaypalOption(),
        "/payment/mbway": (context) => MBWayOption(),
        "/payment/process": (context) => PaymentProcessor(),
        "/user/main": (context) => UserMainPage(),
        "/user/concertInfo": (context) => ConcertInfoPage(),
      },
    );
  }
}




