import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/concert.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';

class ConcertInfoPage extends StatefulWidget {
  ConcertInfoPage({Key key}) : super(key: key);

  @override
  ConcertInfoPageState createState() => ConcertInfoPageState();
}

class ConcertInfoPageState extends State<ConcertInfoPage> {

  @override
  Widget build(BuildContext context) {

    Concert concert = ModalRoute.of(context).settings.arguments;

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
                concert.name,
                concert.description,
                "10th November 2020 9 p.m.", //FIXME
                concert.image
              )
            ]
          )
        )
    );
  }

}