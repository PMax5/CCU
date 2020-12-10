import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/services/UserService.dart';
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
  UserService userService = new UserService();

  Widget createFanMenu(BuildContext context, User user) {
    return MainMenu(
      context,
      user,
      FutureBuilder(
        future: getAvailableConcerts(),
        builder: (context, concerts) {
          if (concerts == null) {
            return Scaffold(
                body: Center(
                    child: Container(
                        padding: EdgeInsets.only(top: 48),
                        alignment: Alignment.topCenter,
                        child: Text(
                          "No concerts available ...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(170, 170, 170, 1),
                              fontSize: 18),
                        ))),
                );
          }
          return ListView.builder(
            itemCount: concerts.data.length,
            itemBuilder: (context, index) {
              Concert concert = concerts.data[index];
              User artist = getArtist(concert.username)
              return Column(
                children: <Widget>[
                  Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 5,
                    child: new InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/user/concertInfo",
                            arguments: Arguments(user, concert));
                      },
                      child: Column(
                        children: [
                          Image.network(concert.image),
                          ListTile(
                            leading: Image.network(artist.imagePath,
                                width: 45, height: 45, fit: BoxFit.cover),
                            title: Text(concert.name),
                            subtitle: Text(
                              '${artist.name}',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.6)),
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
    return MainMenu(
      context,
      user,
      FutureBuilder(
        future: getArtistCurrentConcerts(user.username),
        builder: (context, artistConcerts) {
          if (artistConcerts == null) {
            return Scaffold(
                body: Center(
                    child: Container(
                        padding: EdgeInsets.only(top: 48),
                        alignment: Alignment.topCenter,
                        child: Text(
                          "You haven't created any concerts yet...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromRGBO(170, 170, 170, 1),
                              fontSize: 18),
                        ))),
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pushNamed(context, "/user/concertCreate",
                        arguments: user);
                  },
                  label: Text("CREATE"),
                  icon: Icon(Icons.add),
                  backgroundColor: projectSettings.mainColor,
                ));
          }
          return Scaffold(
              body: ListView.builder(
                itemCount: artistConcerts.data.length,
                itemBuilder: (context, index) {
                  Concert concert = artistConcerts.data[index];
                  return Column(
                    children: <Widget>[
                      Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 5,
                        child: new InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/user/concertInfo",
                                arguments: Arguments(user, concert));
                          },
                          child: Column(
                            children: [
                              Image.network(concert.image),
                              ListTile(
                                leading: ClipOval(
                                  child: Image.network(
                                    user.imagePath,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(concert.name),
                                subtitle: Text(
                                  '${user.Name}',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pushNamed(context, "/user/concertCreate",
                      arguments: user);
                },
                label: Text("CREATE"),
                icon: Icon(Icons.add),
                backgroundColor: projectSettings.mainColor,
              ));
        },
      ),
    );
  }

  Future<List<Concert>> getAvailableConcerts() async {
    try {
      List<Concert> concerts = await concertService.getAllConcerts();
      return concerts.where((c) => c.status != 2 && c.status != 3).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Concert>> getArtistCurrentConcerts(String username) async {
    try {
      List<Concert> artistConcerts =
          await concertService.getArtistConcerts(username);
      return artistConcerts.where((c) => c.status != 2 && c.status != 3).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  Future<User> getArtist(String username) async {
    try {
      User user = await userService.getUser(username);
      return user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      Padding(padding: EdgeInsets.only(top: 40), child: CenteredHeaderLogo()),
      user.type == "FAN"
          ? this.createFanMenu(context, user)
          : this.createArtistMenu(context, user)
    ])));
  }
}