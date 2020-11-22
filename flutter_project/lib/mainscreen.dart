// ignore: avoid_web_libraries_in_flutter
//import 'dart:html';

import 'package:flutter/material.dart';
import 'signup/signup.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget> [
          Image.asset('assets/images/rockw.png', width: double.infinity, height: double.infinity,fit: BoxFit.cover,),
          Center(child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),),
          Positioned(
            left: 100,
            top: 400,
            child: 
            RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              ),
            child: Text('Log in'),
            onPressed: () {},
            ),
          ),
          Positioned(
            right: 100,
            top: 400,
            child: 
            RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              ),
            color: Colors.pink[800],
            child: Text('Sign Up'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp())
              );
            },
            ),
          ),
        ],
      ),
    );
  }
}




/*
 RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0),
        ),
        child: Text('Login'),
        onPressed: () {},
      ),
      RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0),
        ),
        child: Text( "Sign In"),
        onPressed: () {},
      ),

*/