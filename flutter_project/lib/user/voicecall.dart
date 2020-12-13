import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import '../models/user.dart';

class VoiceCall extends StatefulWidget {
  VoiceCall({Key key}) : super(key: key);

  @override
  VoiceCallState createState() => VoiceCallState();
}

class VoiceCallState extends State<VoiceCall> {
  bool _soundOFF = false, _microOFF = false;
  bool _fan1OFF = false, _fan2OFF = false, _fan3OFF = false;
  User user;
  VoiceChannel voiceInfo;
  List<User> participants = new List<User>();

  Widget buttonMuteFan(BuildContext context, int nrFan) {
    if (nrFan == 1) {
      return Padding(
          padding: EdgeInsets.all(10.0),
          child: SizedBox(
              width: 60,
              height: 60,
              child: RaisedButton(
                textColor: _fan1OFF ? projectSettings.mainColor : Colors.white,
                child: _fan1OFF
                    ? Icon(Icons.volume_off, size: 30)
                    : Icon(Icons.volume_up, size: 30),
                color: _fan1OFF ? Colors.white : projectSettings.mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(180.0),
                    side:
                        BorderSide(color: projectSettings.mainColor, width: 4)),
                padding: EdgeInsets.all(10.0),

                // changes icon and color when pressed
                onPressed: () {
                  setState(() {
                    _fan1OFF = !_fan1OFF;
                  });
                },
              )));
    } else if (nrFan == 2) {
      return Padding(
          padding: EdgeInsets.all(10.0),
          child: SizedBox(
              width: 60,
              height: 60,
              child: RaisedButton(
                textColor: _fan2OFF ? projectSettings.mainColor : Colors.white,
                child: _fan2OFF
                    ? Icon(Icons.volume_off, size: 30)
                    : Icon(Icons.volume_up, size: 30),
                color: _fan2OFF ? Colors.white : projectSettings.mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(180.0),
                    side:
                        BorderSide(color: projectSettings.mainColor, width: 4)),
                padding: EdgeInsets.all(10.0),

                // changes icon and color when pressed
                onPressed: () {
                  setState(() {
                    _fan2OFF = !_fan2OFF;
                  });
                },
              )));
    }

    return Padding(
        padding: EdgeInsets.all(10.0),
        child: SizedBox(
            width: 60,
            height: 60,
            child: RaisedButton(
              textColor: _fan3OFF ? projectSettings.mainColor : Colors.white,
              child: _fan3OFF
                  ? Icon(Icons.volume_off, size: 30)
                  : Icon(Icons.volume_up, size: 30),
              color: _fan3OFF ? Colors.white : projectSettings.mainColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(180.0),
                  side: BorderSide(color: projectSettings.mainColor, width: 4)),
              padding: EdgeInsets.all(10.0),

              // changes icon and color when pressed
              onPressed: () {
                setState(() {
                  _fan3OFF = !_fan3OFF;
                });
              },
            )));
  }

  Widget fanProfileCall(
      BuildContext context, String image, String name, int nrFan) {
    return Column(
      children: <Widget>[
        // maybe ill have to add a padding
        Padding(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(image),
                ),),
        Container(
          margin: const EdgeInsets.all(10.0),
          child: Text(name,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
        this.buttonMuteFan(context, nrFan)
      ],
    );
  }

  Widget fansVoiceCall(BuildContext context, dynamic participants) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 25)),
        CenteredHeaderLogo(),
        Padding(padding: EdgeInsets.only(top: 100)),
        CenteredProfile(
           participants[0].imagePath,
           participants[0].name),
        Padding(padding: EdgeInsets.only(top: 100)),
        Center(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                    width: 65,
                    height: 65,
                    child: RaisedButton(
                      textColor:
                          _soundOFF ? projectSettings.mainColor : Colors.white,
                      child: _soundOFF
                          ? Icon(Icons.volume_off, size: 30)
                          : Icon(Icons.volume_up, size: 30),
                      color:
                          _soundOFF ? Colors.white : projectSettings.mainColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(180.0),
                          side: BorderSide(
                              color: projectSettings.mainColor, width: 4)),
                      padding: EdgeInsets.all(16.0),

                      // changes icon and color when pressed
                      onPressed: () {
                        setState(() {
                          _soundOFF = !_soundOFF;
                        });
                      },
                    ))),
            Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                    width: 65,
                    height: 65,
                    child: RaisedButton(
                      textColor:
                          _microOFF ? projectSettings.mainColor : Colors.white,
                      child: _microOFF
                          ? Icon(Icons.mic_off, size: 30)
                          : Icon(Icons.mic, size: 30),
                      color:
                          _microOFF ? Colors.white : projectSettings.mainColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(180.0),
                          side: BorderSide(
                              color: projectSettings.mainColor, width: 4)),
                      padding: EdgeInsets.all(16.0),

                      // changes icon and color when pressed
                      onPressed: () {
                        setState(() {
                          _microOFF = !_microOFF;
                        });
                      },
                    ))),
            MaterialButton(
              onPressed: () {
                  Navigator.pop(context);

              },
              color: Colors.red[900],
              textColor: Colors.white,
              child: Icon(Icons.call_end, size: 30),
              padding: EdgeInsets.all(16),
              shape: CircleBorder(),
            )
          ],
        ))
      ],
    );
  }

  Widget artistsVoiceCall(BuildContext context, dynamic participants) {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 25)),
        CenteredHeaderLogo(),
        Container(
          margin: const EdgeInsets.only(top: 50, bottom: 40),
          child: Text(voiceInfo.name,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),

        // profile of 3 fans
       
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              this.fanProfileCall(
                  context,
                  participants[0].imagePath,
                  participants[0].name,
                  1),
              this.fanProfileCall(
                  context,
                  participants[1].imagePath,
                  participants[1].name,
                  2),
              this.fanProfileCall(
                  context,
                  participants[2].imagePath,
                  participants[2].name,
                  3),
            ],
          ),
        ),

        Padding(padding: EdgeInsets.only(top: 70)),
        Center(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(16.0),
                child: SizedBox(
                    width: 60,
                    height: 60,
                    child: RaisedButton(
                      textColor:
                          _microOFF ? projectSettings.mainColor : Colors.white,
                      child: _microOFF
                          ? Icon(Icons.mic_off, size: 30)
                          : Icon(Icons.mic, size: 30),
                      color:
                          _microOFF ? Colors.white : projectSettings.mainColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(180.0),
                          side: BorderSide(
                              color: projectSettings.mainColor, width: 4)),
                      padding: EdgeInsets.all(10.0),

                      // changes icon and color when pressed
                      onPressed: () {
                        setState(() {
                          _microOFF = !_microOFF;
                        });
                      },
                    ))),
            MaterialButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => ConfirmationDialog(
                            "Are you sure you want to end this voice call?",
                            "By clicking on this button, this voice call will "
                                "immediately end and everyone who was in it will"
                                " have to leave it.", () {
                          endCall(voiceInfo.concertId).then((result) {
                                Navigator.popUntil(context, ModalRoute.withName("/"));
                                Navigator.pushNamed(context, "/user/main", arguments: MainArguments(user,1));
                          });
                      
                        }, () {
                          Navigator.of(context).pop();
                        }));
              },
              color: Colors.red[900],
              textColor: Colors.white,
              child: Icon(Icons.call_end, size: 30),
              padding: EdgeInsets.all(15.5),
              shape: CircleBorder(),
            )
          ],
        ))
      ],
    );
  }
  Future<List<User>> getUsers(int id, String username) async {
     try {
       return await userService.getUsers(id,username);
     } catch (e) {
       print(e.toString());
       return null;
     }
   }
  Future<void> endCall(int id) async {
     try {
       await userService.endCall(id);
     } catch (e) {
       print(e.toString());
     }
   }
  @override
  Widget build(BuildContext context) {
    VoiceArguments voiceArguments = ModalRoute.of(context).settings.arguments;
    user = voiceArguments.user;
    voiceInfo = voiceArguments.infoVoice;
    return FutureBuilder(future: getUsers(voiceInfo.concertId, user.username),
    builder: (context,participants) { 
      if(participants.hasData)
      {
         return Scaffold(
        appBar: AppBar(
          title: Text("Voice Call"),
          backgroundColor: projectSettings.mainColor,
        ),
        body: user.type == "FAN"
            ? this.fansVoiceCall(context,participants.data)
            : this.artistsVoiceCall(context,participants.data));
      }
      return Center(child: CircularProgressIndicator()); });

    
   
   
  }
}
