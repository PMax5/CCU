
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/payment/mbway.dart';
import 'package:flutter_complete_guide/payment/paypal.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import '../settings.dart';
import 'creditcard.dart';

enum PaymentType {
  CREDIT_CARD,
  PAYPAL,
  MBWAY,
  ATM
}

class PaymentOptions extends StatefulWidget {
  PaymentOptions({Key key}) : super(key: key);

  @override
  PaymentOptionsState createState() => PaymentOptionsState();
}

class PaymentOptionsState extends State<PaymentOptions> {

  Settings projectSettings = new Settings();
  PaymentType paymentType;
  int currentStep = 0;

  Widget buildButton(String paymentMethod, PaymentType type, String assetPath) {

    return Padding(
      padding: EdgeInsets.only(left: 6),
      child: ListTile(
          title: Text(
            paymentMethod,
            style: TextStyle(
                fontSize: 22
            ),
          ),
          trailing: Padding(
            padding: EdgeInsets.only(right: 20),
            child: Image.asset(assetPath, fit: BoxFit.cover)
          ),
          leading: Transform.scale(
              scale: 1.5,
              child: Radio(
                value: type,
                groupValue: this.paymentType,
                hoverColor: projectSettings.mainColor,
                focusColor: projectSettings.mainColor,
                activeColor: projectSettings.mainColor,
                onChanged: (PaymentType value) {
                  if (currentStep < 1)
                    currentStep++;

                  setState(() {
                    this.paymentType = value;
                  });
                },
              )
          )
      ),
    );
  }

  Widget buildForm(BuildContext context) {

    return Padding(
        padding: EdgeInsets.only(top: 48),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
             CenteredHeaderLogo(),
              Center(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Image.asset("assets/images/progress_" + currentStep.toString() + ".png", fit: BoxFit.cover)
                  )
              ),
              projectSettings.headerPayment("Payment Options", null),
              this.buildButton("Credit Card", PaymentType.CREDIT_CARD, "assets/images/visa.png"),
              this.buildButton("PayPal", PaymentType.PAYPAL, "assets/images/paypal.png"),
              this.buildButton("MBWay", PaymentType.MBWAY, "assets/images/mbway.png"),
              this.buildButton("ATM", PaymentType.ATM, "assets/images/atm.png"),
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
                              if (currentStep > 0)
                                currentStep--;
                              Navigator.pop(context);
                            },
                          ),
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 25, left: 35),
                        child: Container(
                            width: projectSettings.smallButtonWidth,
                            height: projectSettings.smallButtonHeight,
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

                                  String route;

                                  switch (paymentType) {
                                    case PaymentType.CREDIT_CARD:
                                      route = "/payment/creditcard";
                                      break;
                                    case PaymentType.PAYPAL:
                                      route = "/payment/paypal";
                                      break;
                                    case PaymentType.MBWAY:
                                      route = "/payment/mbway";
                                      break;
                                    case PaymentType.ATM:
                                      break;
                                    default:
                                      showDialog(
                                          context: context,
                                          builder: (_) => TipDialog(
                                              "Notice",
                                              "Please select one payment option before proceeding.",
                                                  () {
                                                Navigator.of(context).pop();
                                              }
                                          )
                                      );
                                      break;
                                  }

                                  if (route == null)
                                    return;

                                  Navigator.pushNamed(context, route);
                                }
                            )
                        )
                    )
                  ],
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
            title: Text("Payment"),
            backgroundColor: projectSettings.mainColor
        ),
        body: this.buildForm(context)
    );
  }

}