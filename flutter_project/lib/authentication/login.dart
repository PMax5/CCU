
import 'package:flutter/material.dart';
import '../settings.dart';
import 'type.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

  Settings projectSettings = new Settings();

  Widget buildFormInputField(String hintText, String invalidInputMessage) {

    OutlineInputBorder inputBorder(Color color) {
      return OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(6.0))
      );
    }

    return Center(
        child: Padding(
            padding: EdgeInsets.only(bottom: 14),
            child: Container(
                width: projectSettings.textInputWidth,
                height: projectSettings.textInputHeight + 25,
                child: TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: inputBorder(Colors.black),
                        focusedBorder: inputBorder(Colors.black),
                        errorBorder: inputBorder(Colors.red),
                        focusedErrorBorder: inputBorder(Colors.red),
                        hintText: hintText
                    ),
                    validator: (value) {
                      if (value.isEmpty)
                        return invalidInputMessage;
                      return null;
                    }
                )
            )
        )
    );
  }

  Widget buildForm(BuildContext context) {
    final signUpFormKey = GlobalKey<FormState>();

    return Padding(
        padding: EdgeInsets.only(top: 48),
        child: Form(
            key: signUpFormKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  this.buildFormInputField('user@example.com', 'Enter an email address.'),
                  this.buildFormInputField('Password', 'Enter a password.'),
                  Center(
                      child: Container(
                          width: projectSettings.textInputWidth,
                          height: projectSettings.textInputHeight,
                          child: ElevatedButton(
                              child: Text(
                                  "LOG IN",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(projectSettings.mainColor),
                              ),
                              onPressed: () {
                                if(signUpFormKey.currentState.validate()) {
                                  //TODO: Implement login.
                                }
                              }
                          )
                      )
                  )
                ]
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Log In"),
            backgroundColor: projectSettings.mainColor
        ),
        body: this.buildForm(context)
    );
  }

}