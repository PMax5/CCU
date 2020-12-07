import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/services/ConcertService.dart';
import '../models/concert.dart';
import '../models/user.dart';
import 'package:flutter_complete_guide/settings.dart';
import 'package:flutter_complete_guide/models/user.dart';

Settings projectSettings = new Settings();
ConcertService _concertService = new ConcertService();
List<String> channelNames = List<String>();

Widget CenteredHeaderLogo() {
  return Center(child: projectSettings.logo);
}

Widget CenteredProfile(String imagePath, String name) {
  return Center(
      child: Column(
    children: [
      Image.asset(imagePath),
      Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(name,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)))
    ],
  ));
}

Widget FormInputField(
    String hintText, String invalidInputMessage, int maxCharacters) {
  OutlineInputBorder inputBorder(Color color) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(6.0)));
  }

  return Center(
      child: Padding(
          padding: EdgeInsets.only(bottom: 14),
          child: Container(
              width: projectSettings.textInputWidth + 20,
              height: projectSettings.textInputHeight + 25,
              child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(maxCharacters)
                  ],
                  decoration: InputDecoration(
                      enabledBorder: inputBorder(Colors.black),
                      focusedBorder: inputBorder(Colors.black),
                      errorBorder: inputBorder(Colors.red),
                      focusedErrorBorder: inputBorder(Colors.red),
                      hintText: hintText),
                  validator: (value) {
                    if (value.isEmpty) return invalidInputMessage;
                    return null;
                  }))));
}

Widget MainMenu(BuildContext context, User user, Widget mainPage) {
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
                      mainPage,
                      ChatRooms(context, user),
                      Notifications(context),
                      ExtraMenu(context, user)
                    ]
                  : [
                      mainPage,
                      ChatRooms(context, user),
                      ExtraMenu(context, user)
                    ]),
        ),
      ],
    ),
  );
}

Future<List<GeneralChannel>> getAllChannels(String username) async {
  try {
    List<GeneralChannel> channels = await _concertService.getConcertsChannels(username);
    return channels;
  } catch(e) {
    print(e.toString());
  }
}

Widget ChatRooms(BuildContext context, User user) {

  List<GeneralChannel> textChannels = new List<GeneralChannel>();
  List<GeneralChannel> voiceChannels = new List<GeneralChannel>();
  channelNames.clear();

  return FutureBuilder(
    future: getAllChannels(user.username),
    builder: (context, channels) {
      if (!channels.hasData) {
        return Center(child: CircularProgressIndicator());
      } else {
        channels.data.forEach((channel) => {
          if (!channelNames.contains(channel.name)) {
            channelNames.add(channel.name),
            channel.voice ? voiceChannels.add(channel) : textChannels.add(channel)
          }
        });
      }

      return ListView(
        children: [
          ListTile(
            title: Text("Voice Calls", style: TextStyle(fontSize: 20)),
          ),
          Image.asset('assets/images/divider.png'),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: voiceChannels.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(voiceChannels[index].name),
                  leading: Icon(Icons.volume_up),
                  trailing: Image.asset(voiceChannels[index].imagePath),
                  onTap: () {
                    if (user.type == "FAN") {
                      Navigator.pushNamed(context, "/user/voicecall",
                          arguments: user);
                    }
                    else {
                      showDialog(
                          context: context,
                          builder: (_) => ConfirmationDialog(
                              "Are you sure you want to start this voice call?",
                              "You will start a voice call with three of your fans.",
                                  () {
                                Navigator.of(context).pop();
                                Navigator.pushNamed(context, "/user/voicecall",
                                    arguments: user);
                              }, () {
                            Navigator.of(context).pop();
                          }));
                    }
                  });
            },
          ),
          ListTile(
            title: Text("Chat Rooms", style: TextStyle(fontSize: 20)),
          ),
          Image.asset('assets/images/divider.png'),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: textChannels.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(textChannels[index].name),
                leading: Icon(Icons.sms),
                onTap: () {
                  Navigator.pushNamed(
                      context,
                      "/user/userchat",
                      arguments: user
                  );
                },
              );
            },
          ),
        ]
      );
    },
  );
}

Widget Notifications(BuildContext context) {
  return ListView(
    children: [
      ListTile(
        title: Text("Notification History", style: TextStyle(fontSize: 20)),
      ),
      Image.asset('assets/images/divider.png'),
      ListTile(
        title: Text("New James Smith’s Concert"),
        trailing: Icon(Icons.delete),
      ),
    ],
  );
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
        //TODO: redirecionar para ecra de perfil
        Navigator.pushNamed(context, "/user/userProfile", arguments: user);
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
          //
          Navigator.pushNamed(context, "/");
        }),
    Divider(
      color: Colors.grey,
      height: 10,
      indent: 10,
      endIndent: 10,
    ),
  ]);
}

Widget ConfirmationDialog(
    String title, String content, Function onConfirm, Function onBack) {
  return AlertDialog(title: Text(title), content: Text(content), actions: <
      Widget>[
    RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
            side: BorderSide(color: Colors.black, width: 2)),
        child: Text('BACK',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        onPressed: onBack),
    ElevatedButton(
        child: Text("CONFIRM", style: TextStyle(fontWeight: FontWeight.bold)),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(projectSettings.mainColor),
        ),
        onPressed: onConfirm)
  ]);
}

Widget TipDialog(String title, String description, Function onOK) {
  return AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        ElevatedButton(
            child: Text("OK", style: TextStyle(fontWeight: FontWeight.bold)),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(projectSettings.mainColor),
            ),
            onPressed: onOK)
      ]);
}

Widget BackButtonLogoHeader(BuildContext context) {
  return Row(children: [
    IconButton(
      padding: const EdgeInsets.only(top: 40, left: 8.0),
      icon: const BackButtonIcon(),
      color: Colors.black,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        Navigator.maybePop(context);
      },
    ),
    Expanded(
        child: Align(
            alignment: Alignment(-0.23, 0.0),
            child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: projectSettings.logo)))
  ]);
}

class Arguments {
  final User logged_in;
  final Concert concert;

  Arguments(this.logged_in, this.concert);
}
