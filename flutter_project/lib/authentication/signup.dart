
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import '../settings.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {

  Settings projectSettings = new Settings();
  Map<String, String> formValues = new Map<String, String>();

  Widget buildFormInputField(String identifier, String hintText, String invalidInputMessage, bool obscure) {

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
                  obscureText: obscure,
                  validator: (value) {
                    if (value.isEmpty)
                      return invalidInputMessage;
                    else {
                      formValues[identifier] = value;
                      return null;
                    }
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
                Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: CenteredHeaderLogo()
                ),
                this.buildFormInputField('email', 'user@example.com', 'Enter an email address.', false),
                this.buildFormInputField('username', 'Username', 'Enter an username.', false),
                this.buildFormInputField('password', 'Password', 'Enter a password.', true),
                Center(
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
                              if(signUpFormKey.currentState.validate()) {
                                Navigator.pushNamed(
                                  context,
                                  "/signup/type",
                                  arguments: formValues
                                );
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
        title: Text("Sign Up"),
        backgroundColor: projectSettings.mainColor
      ),
      body:SingleChildScrollView(
        child: this.buildForm(context)
      ),
    );
  }
  
}