import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:flutter_complete_guide/services/AuthenticationService.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import '../settings.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {

  Settings projectSettings = new Settings();
  AuthenticationService authenticationService = new AuthenticationService();
  Map<String, String> formValues = new Map<String, String>();

  Widget buildFormInputField(String hintText, String invalidInputMessage, bool obscure) {

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
                        formValues[hintText] = value;
                        return null;
                      }
                    }
                )
            )
        )
    );
  }

  Widget buildForm(BuildContext context) {
    final loginFormKey = GlobalKey<FormState>();

    return Padding(
        padding: EdgeInsets.only(top: 48),
        child: Form(
            key: loginFormKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: CenteredHeaderLogo()
                  ),
                  this.buildFormInputField('Username', 'Enter an username.', false),
                  this.buildFormInputField('Password', 'Enter a password.', true),
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
                                if(loginFormKey.currentState.validate()) {
                                  login().then((user) {
                                    if (user != null) {
                                      print("hello");
                                      Navigator.pushNamed(
                                          context,
                                          "/user/main",
                                          arguments: user
                                      );
                                    }
                                    else {
                                      showDialog(
                                          context: context,
                                          builder: (_) => TipDialog(
                                              "Notice",
                                              "Incorrect username or password.",
                                                  () {
                                                Navigator.of(context).pop();
                                              }
                                          )
                                      );
                                    }
                                  });
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

  Future<User> login() async {
    try {
      return await authenticationService.login(formValues['Username'], formValues['Password']);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Log In"),
            backgroundColor: projectSettings.mainColor
        ),
        body: SingleChildScrollView(
          child:this.buildForm(context)
        ),
    );
  }

}