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

  Widget fanMainPage() {
    return FutureBuilder(
      future: getConcerts(),
      builder: (context, concerts) {
        if (!concerts.hasData) {
          print('concerts data ${concerts.data}');
          return Column(
            children: [
              Text("the data is empty"),
              Center(child: CircularProgressIndicator())
            ]
          );
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
                    onTap: () {  //TODO: ecrã com info dinâmica
                      Navigator.pushNamed(context, "/user/concertInfo");
                    },
                    child: Column(
                      children: [
                        Image.asset(concert.image),
                        ListTile(
                          leading: Image.asset('assets/images/mini_james.png'),
                          title: Text(concert.name),
                          subtitle: Text(
                            'Artist: ' + concert.username,
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
    );
  }

  Widget createFanMenu(BuildContext context) {
    return MainMenu(
      context, fanMainPage()
        /*ListView(
          children: [
            /*Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5,
              child: new InkWell(
                onTap: () {  //TODO: ecrã com info dinâmica
                  Navigator.pushNamed(context, "/user/concertInfo");
                },
                child: Column(
                  children: [
                    Image.asset('assets/images/james.png'),
                    ListTile(
                      leading: Image.asset('assets/images/mini_james.png'),
                      title: const Text("James Smith's Concert"),
                      subtitle: Text(
                        'Artist: James Smith',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5,
              child: Column(
                children: [
                  Image.asset('assets/images/concert2.png'),
                  ListTile(
                    leading: Image.asset('assets/images/mini_concert2.png'),
                    title: const Text("Iron Maiden's Concert"),
                    subtitle: Text(
                      'Artist: Iron Maiden',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5,
              child: Column(
                children: [
                  Image.asset('assets/images/concert3.png'),
                  ListTile(
                    leading: Image.asset('assets/images/mini_concert3.png'),
                    title: const Text("Twenty One Pilots' Concert"),
                    subtitle: Text(
                      'Artist: Twenty One Pilots',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5,
              child: Column(
                children: [
                  Image.asset('assets/images/concert4.png'),
                  ListTile(
                    leading: Image.asset('assets/images/mini_concert4.png'),
                    title: const Text("K.Flay's Concert"),
                    subtitle: Text(
                      'Artist: K.Flay',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5,
              child: Column(
                children: [
                  Image.asset('assets/images/concert5.png'),
                  ListTile(
                    leading: Image.asset('assets/images/mini_concert5.png'),
                    title: const Text("Lemaitre's Concert"),
                    subtitle: Text(
                      'Artist: Lemaitre',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5,
              child: Column(
                children: [
                  Image.asset('assets/images/concert6.png'),
                  ListTile(
                    leading: Image.asset('assets/images/mini_concert6.png'),
                    title: const Text("y.azz's Concert"),
                    subtitle: Text(
                      'Artist: y.azz',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                ],
              ),
            )*/
          ],
        )*/
    );
  }

  Widget createArtistMenu(BuildContext context) {
    //TODO: Put the artist pages here!
  }

  Future<List<Concert>> getConcerts() async {
    try {
      List<Concert> concerts = await concertService.getAllConcerts();
      return concerts;
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
            user.type == "FAN" ? this.createFanMenu(context) : this.createArtistMenu(context)
          ]
        )
      )
    );
  }

}