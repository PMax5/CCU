
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {

  Widget buildFormInputField(String hintText, String invalidInputMessage) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText
      ),
      validator: (value) {
        if (value.isEmpty)
          return invalidInputMessage;
        return null;
      }
    );
  }

  Widget buildForm(BuildContext context) {
    final signUpFormKey = GlobalKey<FormState>();

    return Form(
      key: signUpFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          this.buildFormInputField('user@example.com', 'Enter an email address.'),
          this.buildFormInputField('Username', 'Enter an username.'),
          this.buildFormInputField('Password', 'Enter a password.'),
          Center(
            child: ElevatedButton(
              child: Text("Next"),
              onPressed: () {
                if(signUpFormKey.currentState.validate()) {
                  //TODO: Move to the next stage
                } else {
                  //TODO: Show notification to user
                }
              },
            )
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up")
      ),
      body: this.buildForm(context)
    );
  }
  
}