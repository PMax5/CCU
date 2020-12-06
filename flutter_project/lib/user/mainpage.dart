import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/concert.dart';
import 'package:flutter_complete_guide/models/user.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import 'package:flutter_complete_guide/services/ConcertService.dart';

class UserMainPage extends StatefulWidget {
  UserMainPage({Key key}) : super(key: key);

  @override
  UserMainPageState createState() => UserMainPageState();
}

class UserMainPageState extends State<UserMainPage> {

  ConcertService concertService = new ConcertService();

  Widget createFanMenu(BuildContext context, User user) {
    return MainMenu(
      context,
        user,
        FutureBuilder(
          future: getConcerts(),
          builder: (context, concerts) {
            if (!concerts.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: concerts.data.length,
              itemBuilder: (context, index) {
                Concert concert = concerts.data[index];
                return Column(
                  children: <Widget>[
                    Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 5,
                      child: new InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context,
                              "/user/concertInfo",
                              arguments: Arguments(user, concert)
                          );
                        },
                        child: Column(
                          children: [
                            Image.asset(concert.image),
                            ListTile(
                              leading: Image.asset(concert.artistImage),
                              title: Text(concert.name),
                              subtitle: Text(
                                '${concert.artistName}',
                                style: TextStyle(color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
    );
  }

  Widget createArtistMenu(BuildContext context, User user) {
    //TODO: Put the artist pages here!
    return MainMenu(
      context,
      user,
      FutureBuilder(
        future: getArtistConcerts(user.username),
        builder: (context, artistConcerts) {
          if (!artistConcerts.hasData || artistConcerts.data.length == 0) {
            return Container(
                padding: EdgeInsets.only(top: 48),
                child: Text(
                  "You haven't created any concerts yet...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(170, 170, 170, 1),
                      fontSize: 18
                  ),
                )
            );
          }
          return ListView.builder(
            itemCount: artistConcerts.data.length,
            itemBuilder: (context, index) {
              print("concerts ${artistConcerts.data[0]}");
              Concert concert = artistConcerts.data[index];
              return Column(
                children: <Widget>[
                  Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 5,
                    child: new InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context,
                            "/user/concertInfo",
                            arguments: Arguments(user, concert)
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset(concert.image),
                          ListTile(
                            leading: Image.asset(concert.artistImage),
                            title: Text(concert.name),
                            subtitle: Text(
                              '${concert.artistName}',
                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Concert>> getConcerts() async {
    try {
      List<Concert> concerts = await concertService.getAllConcerts();
      return concerts;
    } catch(e) {
      print(e.toString());
    }
  }

  Future<List<Concert>> getArtistConcerts(String username) async {
    try {
      List<Concert> artistConcerts = await concertService.getArtistConcerts(username);
      return artistConcerts;
    } catch(e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: CenteredHeaderLogo()
            ),
            user.type == "FAN" ? this.createFanMenu(context, user) : this.createArtistMenu(context, user)
          ]
        )
      ),
      floatingActionButton: new Visibility(
        visible: (user.type == "ARTIST"),
        child: FloatingActionButton.extended(
          onPressed: () {
            //TODO: link to concert creation page
          },
          label: Text("CREATE"),
          icon: Icon(Icons.add),
          backgroundColor: projectSettings.mainColor,
        ),
      ),
    );
  }
}