
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/payment/paymentprocessor.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import '../settings.dart';

class PaypalOption extends StatefulWidget {
  PaypalOption({Key key}) : super(key: key);

  @override
  PaypalState createState() => PaypalState();
}

class PaypalState extends State<PaypalOption> {

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
                  projectSettings.headerPayment("PayPal", null),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 100),
                      child: Container(
                          width: projectSettings.textInputWidth - 25,
                          child: Image.asset("assets/images/paypal_big.png", fit: BoxFit.cover)
                      )
                    )
                  ),
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
                                      Navigator.pushNamed(context, "/payment/process");
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