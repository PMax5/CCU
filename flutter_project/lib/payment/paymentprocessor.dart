
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../settings.dart';

class PaymentProcessor extends StatefulWidget {
  PaymentProcessor({Key key}) : super(key: key);

  @override
  PaymentProcessorState createState() => PaymentProcessorState();
}

class PaymentProcessorState extends State<PaymentProcessor> {

  Settings projectSettings = new Settings();

  List<Widget> paymentValid(bool isValid) {
    String image = "assets/images/check.png";
    String message = "Payment was processed succesfully";

    List<Widget> widgets = [
      Center(
          child: projectSettings.logo
      )
    ];

    if (!isValid) {
      image = "assets/images/cross.png";
      message = "Error processing payment";
    } else {
      widgets.add(projectSettings.createStep(3));
    }

    widgets.addAll([
      Padding(
          padding: EdgeInsets.only(top: 100),
          child: Center(
              child: Image.asset(image, fit: BoxFit.cover)
          )
      ),
      Padding(
          padding: EdgeInsets.only(top: 25, bottom: 80),
          child: Center(
              child: Text(
                  message,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                  )
              )
          )
      )
    ]);

    if (!isValid) {
      widgets.addAll([
          Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
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
                        'INITIAL PAGE',
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
                          "RETRY PAYMENT",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          )
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(projectSettings.mainColor),
                      ),
                      onPressed: () {
                        //TODO: Retry Payment.
                      }
                  )
              )
          )
      ]);
    } else {
      widgets.add(
          Center(
              child: Container(
                  width: projectSettings.textInputWidth,
                  height: projectSettings.textInputHeight,
                  child: ElevatedButton(
                      child: Text(
                          "INITIAL PAGE",
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
      );
    }

    return widgets;
  }

  Widget buildPage(BuildContext context) {

    return Padding(
        padding: EdgeInsets.only(top: 48),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: paymentValid(false)
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
        body: this.buildPage(context)
    );
  }

}