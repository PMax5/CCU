// ignore: avoid_web_libraries_in_flutter
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/authentication/login.dart';
import 'authentication/signup.dart';
import 'settings.dart';

class MainPage extends StatelessWidget {

  Settings projectSettings = new Settings();
  double buttonWidth = 150;
  double buttonHeight = 52;
  double marginDistance = 40;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget> [
          Image.asset('assets/images/rockw.png', width: double.infinity, height: double.infinity,fit: BoxFit.cover,),
          Center(child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),),
          Positioned(
            left: marginDistance,
            top: 400,
            child: 
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: Container(
                width: buttonWidth,
                height: buttonHeight,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                  child: Text(
                      'LOG IN',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      )
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login())
                    );
                  },
                ),
              )
            )
          ),
          Positioned(
            right: marginDistance,
            top: 400,
            child: 
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: Container(
                width: buttonWidth,
                height: buttonHeight,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                  color: projectSettings.mainColor,
                  child: Text(
                      'SIGN UP',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      )
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp())
                    );
                  },
                ),
              )
            )
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