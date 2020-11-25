
import 'package:flutter/material.dart';
import '../settings.dart';

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
          trailing: Image.asset(assetPath, fit: BoxFit.cover),
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
              Center(
                child: projectSettings.logo
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 30),
                  child: Text(
                      "Payment Options",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25
                      )
                  ),
                ),
              ),
              Center(
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Image.asset("assets/images/progress_" + currentStep.toString() + ".png", fit: BoxFit.cover)
                  )
              ),
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
                        padding: EdgeInsets.only(top: 25, left: 30),
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
                                  //TODO: Move to the next stage (Main user page).
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