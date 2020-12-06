
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import '../settings.dart';

class CreditCardOption extends StatefulWidget {
  CreditCardOption({Key key}) : super(key: key);

  @override
  CreditCardState createState() => CreditCardState();
}

class CreditCardState extends State<CreditCardOption> {

  Settings projectSettings = new Settings();

  Widget buildForm(BuildContext context) {
    final signUpFormKey = GlobalKey<FormState>();

    return Padding(
        padding: EdgeInsets.only(top: 48),
        child: Form(
            key: signUpFormKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CenteredHeaderLogo(),
                  projectSettings.createStep(2),
                  projectSettings.headerPayment("Credit Card", "assets/images/visa.png"),
                  FormInputField('Card Number', 'Enter a credit card number.', 16),
                  Center(
                    child: Container(
                        width: projectSettings.textInputWidth + 20,
                        child: Row(
                            children: <Widget>[
                              Container(
                                  width: projectSettings.smallButtonWidth + 20,
                                  child: FormInputField("MM/AA", "Enter a month/year value.", 4)
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Container(
                                    width: projectSettings.smallButtonWidth,
                                    child: FormInputField("CVV", "Enter your card's CVV digits.", 3)
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
                                        showDialog(
                                            context: context,
                                            builder: (_) => ConfirmationDialog(
                                                "Payment Confirmation",
                                                "Do you wish to continue with this purchase?",
                                                    () {
                                                  Navigator.of(context).pop();
                                                  Navigator.pushNamed(
                                                      context,
                                                      "/payment/process",
                                                      arguments: ModalRoute.of(context).settings.arguments
                                                  );
                                                },
                                                    () {
                                                  Navigator.of(context).pop();
                                                }
                                            )
                                        );
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