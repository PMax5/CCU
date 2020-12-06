import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/concert.dart';
import '../models/user.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import 'package:flutter_complete_guide/services/ConcertService.dart';

class ConcertInfoPage extends StatefulWidget {
  ConcertInfoPage({Key key}) : super(key: key);

  @override
  ConcertInfoPageState createState() => ConcertInfoPageState();
}

class ConcertInfoPageState extends State<ConcertInfoPage> {

  ConcertService concertService = new ConcertService();

  Widget ConcertInfoMenu(BuildContext context, Arguments arguments) {

    Concert concert = arguments.concert;
    User user = arguments.logged_in;

    return MainMenu(
        context,
        user,
        Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Image.asset(concert.image, fit: BoxFit.fill),
              ),
              Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                      children: [
                        ListTile(
                            title: Text(
                                concert.name,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)
                            ),
                            subtitle: Padding(
                              padding : EdgeInsets.only(top: 6.0),
                              child: Text(
                                  "10th November 2020 9 p.m.", // FIXME
                                  style: TextStyle(fontSize: 15, color: Colors.black)
                              ),
                            ),
                            trailing: Container(
                              width: 140,
                              height: 40,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(5.0),
                                    side: BorderSide(
                                        color: Colors.black,
                                        width: 2
                                    )
                                ),
                                child: Text(
                                    (user.type == 'FAN' ? 'ARTIST PROFILE' : 'EDIT'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    )
                                ),
                                onPressed: () {
                                  // TODO create artist profile and edit concert page
                                  Navigator.pushNamed(context, (user.type == 'FAN' ? "/login" : "/login"));
                                },
                              ),
                            )
                        ),
                        ListTile(
                          title: Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: const Text(
                                "About the concert",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)
                            ),
                          ),
                          subtitle: Padding(
                            padding : EdgeInsets.only(top: 6.0),
                            child: Text(
                                concert.description,
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 15, color: Colors.black)
                            ),
                          ),
                        ),
                      ]
                  )
              ),
              // TODO change button according to state of ticket (if bought or not)
              ConcertActionButton(concert, user)
            ]
        ));
  }

  Widget ConcertActionButton(Concert concert, User user) {
    return FutureBuilder(
        future: getFanConcerts(user.username),
        builder: (context, bought_concerts) {
          if (!bought_concerts.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          bool bought = false;
          bought_concerts.data.forEach((c) {
            if (c.id == concert.id) {
              bought = true;
            }
          });
          if (user.type == "FAN") {
            if (bought) {
              // TODO change this to go to stream
              return BottomButtonWithDialog(
                  context, 'GO TO STREAM', "/payment", Arguments(user, concert),
                  "Voice call with the artist",
                  "By going to the stream, you’re enabled to win a voice call with the \ "
                    "artist along with other fans at the end of the concert. You’ll receive \ "
                    "a notification in case this happens.", 350
              );
            }
            return LargeBottomButton(context, 'BUY TICKET', "/payment", Arguments(user, concert));
          }
          // TODO change this to go to stream
          // FIXME not aligned
          return Row(
            children: [
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0, bottom: 20.0),
                    child: Container(
                      width: 175,
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
                            'CANCEL STREAM',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            )
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (_) => ConfirmationDialog(
                                  "Are you sure you want to cancel this concert?",
                                  "By cancelling this concert, you are deleting the concert info and if people \ "
                                      "already bought tickets for this concert, they will be automatically refunded.",
                                      () {
                                    Navigator.of(context).pop();
                                    Navigator.pushNamed(
                                        context,
                                        "/payment", // TODO create cancel concert page
                                        arguments: Arguments(user, concert)
                                    );
                                  },
                                      () {
                                    Navigator.of(context).pop();
                                  }
                              )
                          );
                        },
                      ),
                    ),
                  )
                )
              ),
              BottomButtonWithDialog(
                context, 'START STREAM', "/payment", Arguments(user, concert),
                "Are you sure you want to start the concert?",
                "By clicking on this button, your stream will start immediately and everyone \ "
                " who bought a ticket for it will have access to the stream.",
                175
              )
            ]
          );
    });
  }

  Widget LargeBottomButton(BuildContext context, String buttonText, String pageTo, Arguments arguments) {
    return Expanded(
        child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Container(
                width: 350,
                height: projectSettings.smallButtonHeight,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                  color: projectSettings.mainColor,
                  child: Text(
                      buttonText,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      )
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                        context,
                        pageTo,
                        arguments: arguments
                    );
                  },
                ),
              ),
            )
        )
    );
  }

  // FIXME repeated code
  Widget BottomButtonWithDialog(BuildContext context, String buttonText, String pageTo, Arguments arguments, String title, String text, double width) {
    return Expanded(
        child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Container(
                width: width,
                height: projectSettings.smallButtonHeight,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                  color: projectSettings.mainColor,
                  child: Text(
                      buttonText,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      )
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) => ConfirmationDialog(
                            title,
                            text,
                                () {
                              Navigator.of(context).pop();
                              Navigator.pushNamed(
                                  context,
                                  pageTo,
                                  arguments: arguments
                              );
                            },
                                () {
                              Navigator.of(context).pop();
                            }
                        )
                    );
                  },
                ),
              ),
            )
        )
    );
  }

  Future<List<Concert>> getFanConcerts(String username) async {
    try {
      List<Concert> concerts = await concertService.getArtistConcerts(username);
      return concerts;
    } catch(e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Arguments arguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BackButtonLogoHeader(context),
              ConcertInfoMenu(context, arguments)
            ]
          )
        )
    );
  }

}