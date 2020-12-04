import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/user.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';

class UserMainPage extends StatefulWidget {
  UserMainPage({Key key}) : super(key: key);

  @override
  UserMainPageState createState() => UserMainPageState();
}

class UserMainPageState extends State<UserMainPage> {

  Widget createFanMenu(BuildContext context) {
    return MainMenu(
      context,
        ListView(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 5,
              child: new InkWell(
                onTap: () {  //TODO: ecra com info do concerto
                  Navigator.pushNamed(context, "/login");
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
            )
          ],
        ),
        ListView(
          children: [
            ListTile(
              title: Text("Voice Calls",
                  style: TextStyle(fontSize: 20)),
            ),
            Image.asset('assets/images/divider.png'),
            ListTile(
              title: Text("James Smith"),
              leading: Icon(Icons.volume_up),
              trailing:Image.asset('assets/images/mini_james.png'),
            ),
            ListTile(
              title: Text("Chat Rooms",
                  style: TextStyle(fontSize: 20)),
            ),
            Image.asset('assets/images/divider.png'),
            ListTile(
              title: Text("James Smith's Concert"),
              leading: Icon(Icons.sms),
            ),
          ],
        ),
        ListView(
          children: [
            ListTile(
              title: Text("Notification History",
                  style: TextStyle(fontSize: 20)),
            ),
            Image.asset('assets/images/divider.png'),
            ListTile(
              title: Text("New James Smith’s Concert"),
              trailing: Icon(Icons.delete),
            ),
          ],
        ),
        ListView(
            children: [
              Divider(
                color: Colors.grey,
                height: 10,
                indent: 10,
                endIndent: 10,
              ),
              ListTile(
                title: Text("Profile",
                    style: TextStyle(fontSize: 20)),
                leading: Icon(Icons.person, size: 35),
                onTap: () { //TODO: redirecionar para ecra de perfil
                  Navigator.pushNamed(context, "/login");
                },
              ),
              Divider(
                color: Colors.grey,
                height: 10,
                indent: 10,
                endIndent: 10,
              ),
              ListTile(
                  title: Text("Log Out",
                      style: TextStyle(fontSize: 20)),
                  leading: Icon(Icons.logout, size: 35),
                  onTap: () { //
                    Navigator.pushNamed(context, "/");
                  }
              ),
              Divider(
                color: Colors.grey,
                height: 10,
                indent: 10,
                endIndent: 10,
              ),
            ]
        )
    );
  }

  Widget createArtistMenu(BuildContext context) {
    //TODO: Put the artist pages here!
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