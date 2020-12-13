import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import 'package:flutter_complete_guide/services/ConcertService.dart';
import '../settings.dart';
import '../models/user.dart';

class PaymentProcessor extends StatefulWidget {
  PaymentProcessor({Key key}) : super(key: key);

  @override
  PaymentProcessorState createState() => PaymentProcessorState();
}

class PaymentProcessorState extends State<PaymentProcessor> {
  ConcertService concertService = new ConcertService();

  Settings projectSettings = new Settings();

  List<Widget> paymentValid(bool isValid) {
    String image = "http://web.ist.utl.pt/ist189407/assets/images/check.png";
    String message = "Payment was processed succesfully";

    List<Widget> widgets = [CenteredHeaderLogo()];

    if (!isValid) {
      image = "http://web.ist.utl.pt/ist189407/assets/images/cross.png";
      message = "Error processing payment";
    } else {
      widgets.add(projectSettings.createStep(3));
    }

    widgets.addAll([
      Padding(
          padding: EdgeInsets.only(top: 100),
          child: Center(child: Image.network(image, fit: BoxFit.cover))),
      Padding(
          padding: EdgeInsets.only(top: 25, bottom: 80),
          child: Center(
              child: Text(message,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22))))
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
                        side: BorderSide(color: Colors.black, width: 2)),
                    child: Text('INITIAL PAGE',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    onPressed: () {
                      Navigator.popUntil(
                          context, ModalRoute.withName("/user/main"));
                    },
                  ),
                ))),
        Center(
            child: Container(
                width: projectSettings.textInputWidth,
                height: projectSettings.textInputHeight,
                child: ElevatedButton(
                    child: Text("RETRY PAYMENT",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          projectSettings.mainColor),
                    ),
                    onPressed: () {
                      Navigator.popUntil(
                          context, ModalRoute.withName("/payment"));
                    })))
      ]);
    } else {
      Arguments arguments = ModalRoute.of(context).settings.arguments;
      widgets.add(Center(
          child: Container(
              width: projectSettings.textInputWidth,
              height: projectSettings.textInputHeight,
              child: ElevatedButton(
                  child: Text("INITIAL PAGE",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        projectSettings.mainColor),
                  ),
                  onPressed: () {
                    buyTicket(arguments.logged_in.username,  arguments.concert.id).then((newUser){
                        Navigator.popUntil(context, ModalRoute.withName("/"));
                        Navigator.pushNamed(context, "/user/main",arguments: MainArguments(newUser,0));

                    } );

                  }))));
    }

  
    return widgets;
  }

  Widget buildPage(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 48),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: paymentValid(true)));
  }

  Future<User> buyTicket(String username, int concertId) async {
    try {
      return await concertService.purchaseTicket(username, concertId);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Payment"), backgroundColor: projectSettings.mainColor),
        body: this.buildPage(context));
  }
}
