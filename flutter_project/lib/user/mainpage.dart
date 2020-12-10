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

  Widget ChatRooms(BuildContext context, User user) {
    return Container();
  }

  Widget ExtraMenu(BuildContext context, User user) {
    return ListView(children: [
      Divider(
        color: Colors.grey,
        height: 10,
        indent: 10,
        endIndent: 10,
      ),
      ListTile(
        title: Text("Profile", style: TextStyle(fontSize: 20)),
        leading: Icon(Icons.person, size: 35),
        onTap: () {
          Navigator.pushNamed(context, "/user/userProfile", arguments: ProfileArguments(user, true));
        },
      ),
      Divider(
        color: Colors.grey,
        height: 10,
        indent: 10,
        endIndent: 10,
      ),
      ListTile(
          title: Text("Log Out", style: TextStyle(fontSize: 20)),
          leading: Icon(Icons.logout, size: 35),
          onTap: () {
            Navigator.popUntil(context, ModalRoute.withName("/"));
          }),
      Divider(
        color: Colors.grey,
        height: 10,
        indent: 10,
        endIndent: 10,
      ),
    ]);
  }

  Widget Notifications(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text("Notification History", style: TextStyle(fontSize: 20)),
        ),
        Image.network(
            'http://web.ist.utl.pt/ist189407/assets/images/divider.png'),
        ListTile(
          title: Text("New James Smith’s Concert"),
          trailing: Icon(Icons.delete),
        ),
      ],
    );
  }

  Widget MainMenu(BuildContext context, User user) {
  return DefaultTabController(
    length: user.type == "FAN" ? 4 : 3,
    child: Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: TabBar(
                    unselectedLabelColor: Color.fromRGBO(100, 100, 100, 1),
                    labelColor: projectSettings.mainColor,
                    indicatorColor: projectSettings.mainColor,
                    tabs: user.type == "FAN"
                        ? [
                            Tab(icon: Icon(Icons.library_music)),
                            Tab(icon: Icon(Icons.forum)),
                            Tab(icon: Icon(Icons.notifications)),
                            Tab(icon: Icon(Icons.menu))
                          ]
                        : [
                            Tab(icon: Icon(Icons.library_music)),
                            Tab(icon: Icon(Icons.forum)),
                            Tab(icon: Icon(Icons.menu))
                          ]))),
        Container(
          height: MediaQuery.of(context).size.height - 150,
          child: TabBarView(
              children: user.type == "FAN"
                  ? [
                      createFanMenu(context,user),
                      ChatRooms(context, user),
                      Notifications(context),
                      ExtraMenu(context, user)
                    ]
                  : [
                      createArtistMenu(context,user),
                      ChatRooms(context, user),
                      ExtraMenu(context, user)
                    ]),
        ),
      ],
    ),
  );
}

  Widget createFanMenu(BuildContext context, User user) {
    getAvailableConcerts().then((concerts) { 
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
            getArtist(concert.username).then((artist) {
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
            });
            return Column();
            
          },
        );
    }
  }

  Widget createArtistMenu(BuildContext context, User user) {
    getArtistCurrentConcerts(user.username).then((artistConcerts) {
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
                                        '${user.name}',
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
    }
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
      this.MainMenu(context, user)
    ])));
  }
}