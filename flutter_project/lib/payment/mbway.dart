
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import '../settings.dart';

class MBWayOption extends StatefulWidget {
  MBWayOption({Key key}) : super(key: key);

  @override
  MBWayState createState() => MBWayState();
}

class MBWayState extends State<MBWayOption> {

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
                  projectSettings.headerPayment("MBWay", "assets/images/mbway.png"),
                  FormInputField('Phone Number', 'Enter a phone number.', 9),
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