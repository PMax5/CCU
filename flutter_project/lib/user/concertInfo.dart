import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/concert.dart';
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
    String username = arguments.logged_in_username;

    return MainMenu(
        context,
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
                                    'ARTIST PROFILE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                    )
                                ),
                                onPressed: () {
                                  // TODO create artist screen
                                  Navigator.pushNamed(context, "/login");
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
              ConcertActionButton(concert, username)
            ]
        ));
  }

  Widget ConcertActionButton(Concert concert, String userUsername) {
    return FutureBuilder(
        future: getFanConcerts(userUsername),
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
          if (bought) {
            return LargeBottomButton(context, 'GO TO STREAM', "/payment", Arguments(userUsername, concert));
          }
          return LargeBottomButton(context, 'BUY TICKET', "/payment", Arguments(userUsername, concert));
    });
  }

  Future<bool> ticketBought(Concert concert, String userUsername) async {
    List<Concert> bought_concerts = await getFanConcerts(userUsername);
    bought_concerts.forEach((c) {
      if (c.id == concert.id) {
        return true;
      }
    });
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