import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConcertStream extends StatefulWidget {
  ConcertStream({Key key}) : super(key: key);

  @override
  ConcertStreamState createState() => ConcertStreamState();
}

class ConcertStreamState extends State<ConcertStream> {


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return Scaffold(
      body: Stack(
          children: <Widget> [
            Image.asset('assets/images/concert5.png', width: double.infinity, height: double.infinity,fit: BoxFit.cover),
            Row(
              children: [
                Align(
                  alignment: FractionalOffset.topLeft,
                  child: IconButton(
                    padding: const EdgeInsets.only(top:20, left: 20.0),
                    icon: const BackButtonIcon(),
                    color: Colors.white,
                    tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                    onPressed: () {
                      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                      Navigator.maybePop(context);
                    },
                  )
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.topRight,
                    child: IconButton(
                      padding: const EdgeInsets.only(top:20, right: 20.0),
                      icon: Icon(Icons.forum),
                      iconSize: 40,
                      color: Colors.white,
                      onPressed: () {
                        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                        Navigator.pushNamed(
                            context,
                            "/login", // TODO change this to chat screen
                            arguments:  ModalRoute.of(context).settings.arguments
                        );
                      },
                    )
                  )
                )
              ]
            )
          ]
      )
    );
  }
}