import 'package:flutter/material.dart';

import 'screen1.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {   //ctrl + shift + R (refactor)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Screen1(), //   <-- screen1
      ),
    );
  }
}




