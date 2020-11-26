
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../settings.dart';

class PaymentSuccess extends StatefulWidget {
  PaymentSuccess({Key key}) : super(key: key);

  @override
  PaymentSuccessState createState() => PaymentSuccessState();
}

class PaymentSuccessState extends State<PaymentSuccess> {

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
                  Center(
                      child: projectSettings.logo
                  ),
                  projectSettings.createStep(3),
                  Center(
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Center(
                                  child: Container(
                                    width: projectSettings.textInputWidth,
                                    height: projectSettings.textInputHeight,
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
                              )
                          ),
                          Center(
                              child: Container(
                                  width: projectSettings.textInputWidth,
                                  height: projectSettings.textInputHeight,
                                  child: ElevatedButton(
                                      child: Text(
                                          "OPEN PAYPAL ACCOUNT",
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