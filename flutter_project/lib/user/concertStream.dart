import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/concert.dart';
import '../models/user.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import 'package:flutter_complete_guide/services/ConcertService.dart';

class ConcertStream extends StatefulWidget {
  ConcertStream({Key key}) : super(key: key);

  @override
  ConcertStreamState createState() => ConcertStreamState();
}

class ConcertStreamState extends State<ConcertStream> {
  ConcertService concertService = new ConcertService();

  Widget endStreamAlignedButton(User user, int concertId) {
    return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: endStreamButton(user, concertId)));
  }

  Widget endStreamButton(User user, int concertId) {
    return Container(
        width: 100,
        height: 45,
        child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.black, width: 2)),
            child: Text('End Stream',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black)),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => ConfirmationDialog(
                          "Are you sure you want to end the concert?",
                          "By clicking on this button, your stream will end immediately \ "
                              "and no one will have access to it.", () {
                        SystemChrome.setPreferredOrientations(
                            [DeviceOrientation.portraitUp]);
                        endConcert(user.username, concertId);
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, "/user/main",
                            arguments: user);
                      }, () {
                        Navigator.of(context).pop();
                      }));
            }));
  }

  Future<void> endConcert(String username, int concertId) async {
    try {
      await concertService.endConcert(username, concertId);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<GeneralChannel> getConcertChannel(String username) async {
    try {
      List<GeneralChannel> channels =
          await concertService.getConcertsChannels(username);
      return channels[0];
    } catch (e) {
      print("Could not load concert text channel.");
    }
  }

  @override
  Widget build(BuildContext context) {
    Arguments arguments = ModalRoute.of(context).settings.arguments;
    User user = arguments.logged_in;
    Concert concert = arguments.concert;

    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    return Scaffold(
        body: Stack(children: <Widget>[
      Image.network(concert.image,
          width: double.infinity, height: double.infinity, fit: BoxFit.cover),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Align(
            alignment: FractionalOffset.topLeft,
            child: IconButton(
              padding: const EdgeInsets.only(top: 20, left: 20.0),
              icon: const BackButtonIcon(),
              color: Colors.white,
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
              onPressed: () {
                SystemChrome.setPreferredOrientations(
                    [DeviceOrientation.portraitUp]);
                Navigator.maybePop(context);
              },
            )),
        Expanded(
            child: Align(
                alignment: FractionalOffset.topRight,
                child: IconButton(
                  padding: const EdgeInsets.only(top: 20, right: 20.0),
                  icon: Icon(Icons.forum),
                  iconSize: 40,
                  color: Colors.white,
                  onPressed: () {
                    SystemChrome.setPreferredOrientations(
                        [DeviceOrientation.portraitUp]);

                    getConcertChannel(user.username).then((channel) => {
                          Navigator.pushNamed(context, "/user/userchat",
                              arguments: ChannelArguments(user, channel))
                        });
                  },
                )))
      ]),
      (user.type == 'ARTIST'
          ? endStreamAlignedButton(user, concert.id)
          : Container())
    ]));
  }
}
