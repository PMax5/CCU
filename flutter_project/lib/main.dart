import 'package:flutter/material.dart';

import 'mainscreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {   //ctrl + shift + R (refactor)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MainPage(), //   <-- screen1
      ),
    );
  }
}




