import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';

class VoiceCall extends StatefulWidget {
  VoiceCall({Key key}) : super(key: key);

  @override
  VoiceCallState createState() => VoiceCallState();
}

class VoiceCallState extends State<VoiceCall> {
  bool _soundON = false, _microON = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Voice Call"),
          backgroundColor: projectSettings.mainColor,
        ),
        body: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 25)),
            CenteredHeaderLogo(),
            Padding(padding: EdgeInsets.only(top: 100)),
            CenteredProfile('assets/images/profile_artist.png', 'James Smith'),
            Padding(padding: EdgeInsets.only(top: 100)),
            Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget> [
                    Padding(
                        padding: EdgeInsets.all(16.0),
                        child: SizedBox(
                            width: 65,
                            height: 65,
                            child: RaisedButton(
                              textColor: _soundON ? projectSettings.mainColor : Colors.white,
                              child: _soundON ?
                              Icon(Icons.volume_off, size:30) :
                              Icon(Icons.volume_up, size: 30),
                              color: _soundON ? Colors.white : projectSettings.mainColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(180.0),
                                  side: BorderSide(
                                      color: projectSettings.mainColor,
                                      width: 4
                                  )
                              ),
                              padding: EdgeInsets.all(16.0),

                              // changes icon and color when pressed
                              onPressed: () {
                                setState(() {
                                  _soundON = !_soundON;
                                });
                              },
                            )
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.all(16.0),
                        child: SizedBox(
                            width: 65,
                            height: 65,
                            child: RaisedButton(
                              textColor: _microON ? projectSettings.mainColor : Colors.white,
                              child: _microON ?
                              Icon(Icons.mic_off, size:30) :
                              Icon(Icons.mic, size: 30),
                              color: _microON ? Colors.white : projectSettings.mainColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(180.0),
                                  side: BorderSide(
                                      color: projectSettings.mainColor,
                                      width: 4
                                  )
                              ),
                              padding: EdgeInsets.all(16.0),

                              // changes icon and color when pressed
                              onPressed: () {
                                setState(() {
                                  _microON = !_microON;
                                });
                              },
                            )
                        )
                    ),
                    MaterialButton(
                      onPressed: () {
                        //TODO: end call
                        showDialog(
                            context: context,
                            builder: (_) => ConfirmationDialog(
                                "Are you sure you want to quit this voice call?",
                                "You will not be able to join the voice call again.",
                                    () {
                                  Navigator.of(context).pop();
                                  Navigator.pushNamed(context, "/login");
                                },
                                    () {
                                  Navigator.of(context).pop();
                                }
                            )
                        );
                      },
                      color: Colors.red[900],
                      textColor: Colors.white,
                      child: Icon(
                          Icons.call_end,
                          size: 30
                      ),
                      padding: EdgeInsets.all(16),
                      shape: CircleBorder(),
                    )
                  ],
                )
            )
          ],
        )
    );
  }
}