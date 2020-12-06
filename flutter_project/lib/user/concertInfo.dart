import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/concert.dart';
import '../models/user.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';

class ConcertInfoPage extends StatefulWidget {
  ConcertInfoPage({Key key}) : super(key: key);

  @override
  ConcertInfoPageState createState() => ConcertInfoPageState();
}

class ConcertInfoPageState extends State<ConcertInfoPage> {

  @override
  Widget build(BuildContext context) {

    Map args = ModalRoute.of(context).settings.arguments as Map;
    Concert concert = args["concert"];
    User user = args["user"];

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BackButtonLogoHeader(context),
              ConcertInfoMenu(
                context,
                concert.name,
                concert.description,
                "10th November 2020 9 p.m.", //FIXME
                concert.image,
                user
              )
            ]
          )
        )
    );
  }

}