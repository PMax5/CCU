import 'package:flutter/material.dart';

class Settings {
  final double textInputWidth = 320;
  final double textInputHeight = 52;
  final double smallButtonWidth = 150;
  final double smallButtonHeight = 52;
  final Color mainColor = Color.fromRGBO(149, 0, 62, 1);
  final Image logo = Image.asset('assets/images/logo.png', fit: BoxFit.cover);

  Widget headerPayment(String option, String imagePath) {

    Widget headerTitle;
    Widget text = Padding(
        padding: EdgeInsets.only(top: 10, bottom: 30),
        child: Text(
            option,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25
            )
        )
    );

    if (imagePath != null) {
      headerTitle = ListTile(
        title: text,
        trailing: Padding(
          padding: EdgeInsets.only(right: 60),
          child:  Image.asset(imagePath, fit: BoxFit.cover)
        ),
      );
    } else {
      headerTitle = ListTile(
        title: text
      );
    }

    return Center(
      child: headerTitle
    );
  }

  Widget createStep(int currentStep) {
    return Center(
        child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Image.asset("assets/images/progress_" + currentStep.toString() + ".png", fit: BoxFit.cover)
        )
    );
  }

}