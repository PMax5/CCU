import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';

class ConcertInfoPage extends StatefulWidget {
  ConcertInfoPage({Key key}) : super(key: key);

  @override
  ConcertInfoPageState createState() => ConcertInfoPageState();
}

class ConcertInfoPageState extends State<ConcertInfoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: CenteredHeaderLogo()
              ),
              ConcertInfoMenu(
                context,
                "James Smith's Concert",
                "The long wait is over: Portugal is scheduled to meet with James Smith at Altice Arena, in Lisbon. \ "
                    "This unique date is part of the European tour scheduled for autumn, which will feature \"I love you\", \ "
                    "the first James Smith’s original album in six years.",
                "10th November 2020 9 p.m.",
                "assets/images/james.png"
              )
            ]
          )
        )
    );
  }

}