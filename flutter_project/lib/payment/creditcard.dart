
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../settings.dart';

class CreditCardOption extends StatefulWidget {
  CreditCardOption({Key key}) : super(key: key);

  @override
  CreditCardState createState() => CreditCardState();
}

class CreditCardState extends State<CreditCardOption> {

  Settings projectSettings = new Settings();

  Widget buildFormInputField(String hintText, String invalidInputMessage, int maxCharacters) {

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
                width: projectSettings.textInputWidth + 20,
                height: projectSettings.textInputHeight + 25,
                child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(maxCharacters)
                    ],
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
                  Center(
                      child: projectSettings.logo
                  ),
                  projectSettings.headerPayment("Credit Card", "assets/images/visa.png"),
                  projectSettings.createStep(2),
                  this.buildFormInputField('Card Number', 'Enter a credit card number.', 16),
                  Center(
                    child: Container(
                        width: projectSettings.textInputWidth + 20,
                        child: Row(
                            children: <Widget>[
                              Container(
                                  width: projectSettings.smallButtonWidth + 20,
                                  child: this.buildFormInputField("MM/AA", "Enter a month/year value.", 4)
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                    width: projectSettings.smallButtonWidth,
                                    child: this.buildFormInputField("CVV", "Enter your card's CVV digits.", 3)
                                )
                              )
                            ]
                        )
                    )
                  ),
                  Center(
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(top: 25, left: 25),
                              child: Container(
                                width: projectSettings.smallButtonWidth,
                                height: projectSettings.smallButtonHeight,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(5.0),
                                      side: BorderSide(
                                          color: Colors.black,
                                          width: 2
                                      )
                                  ),
                                  child: Text(
                                      'BACK',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black
                                      )
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 25, left: 40),
                              child: Container(
                                  width: projectSettings.smallButtonWidth,
                                  height: projectSettings.smallButtonHeight,
                                  child: ElevatedButton(
                                      child: Text(
                                          "CONFIRM",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold
                                          )
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(projectSettings.mainColor),
                                      ),
                                      onPressed: () {
                                        //TODO: Change to payment status page.
                                      }
                                  )
                              )
                          )
                        ],
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
            title: Text("Payment"),
            backgroundColor: projectSettings.mainColor
        ),
        body: this.buildForm(context)
    );
  }

}