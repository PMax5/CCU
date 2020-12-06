
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import '../settings.dart';

enum Type {
  ARTIST,
  FAN
}

class SignUpType extends StatefulWidget {
  SignUpType({Key key}) : super(key: key);

  @override
  SignUpTypeState createState() => SignUpTypeState();
}

class SignUpTypeState extends State<SignUpType> {

  Settings projectSettings = new Settings();
  Type userType = Type.FAN;

  Widget buildForm(BuildContext context) {
    Map<String, String> formValues = ModalRoute.of(context).settings.arguments;

    return Padding(
        padding: EdgeInsets.only(top: 48),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: CenteredHeaderLogo()
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text(
                      "Which of these apply to you?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25
                      )
                  ),
                )
              ),
              Padding(
                padding: EdgeInsets.only(left: 6),
                child: ListTile(
                  title: const Text(
                    'Fan',
                    style: TextStyle(
                        fontSize: 22
                    ),
                  ),
                  leading: Radio(
                    value: Type.FAN,
                    groupValue: userType,
                    hoverColor: projectSettings.mainColor,
                    focusColor: projectSettings.mainColor,
                    activeColor: projectSettings.mainColor,
                    onChanged: (Type value) {
                      setState(() {
                        userType = value;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6),
                child: ListTile(
                  title: const Text(
                    'Artist',
                    style: TextStyle(
                        fontSize: 22
                    ),
                  ),
                  leading: Radio(
                    value: Type.ARTIST,
                    groupValue: userType,
                    hoverColor: projectSettings.mainColor,
                    focusColor: projectSettings.mainColor,
                    activeColor: projectSettings.mainColor,
                    onChanged: (Type value) {
                      setState(() {
                        userType = value;
                      });
                    },
                  ),
                ),
              ),
              Center(
                  child: Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Container(
                          width: projectSettings.textInputWidth,
                          height: projectSettings.textInputHeight,
                          child: ElevatedButton(
                              child: Text(
                                "NEXT",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(projectSettings.mainColor),
                              ),
                              onPressed: () {
                                formValues["type"] = userType == Type.FAN ? "FAN" : "ARTIST";
                                Navigator.pushNamed(
                                    context,
                                    "/signup/profile",
                                    arguments: formValues
                                );
                              }
                          )
                      )
                  )
              )
            ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Sign Up"),
            backgroundColor: projectSettings.mainColor
        ),
        body: this.buildForm(context)
    );
  }

}