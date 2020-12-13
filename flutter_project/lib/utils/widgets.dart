import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/services/UserService.dart';
import '../models/user.dart';
import 'package:flutter_complete_guide/settings.dart';
import 'package:flutter_complete_guide/models/user.dart';
import '../models/concert.dart';

Settings projectSettings = new Settings();
UserService userService = new UserService();
Widget CenteredHeaderLogo() {
  return Center(child: projectSettings.logo);
}


Widget CenteredProfile(String imagePath, String name) {
  return Center(
      child: Column(
    children: [
      ClipOval(
        child: Image.network(
          imagePath,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
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

Future<List<VoiceChannel>> getVoiceChannels(String username,String type) async {
  try {
    List<VoiceChannel> voiceChannels = await userService.getVoiceChannels(username);
    print(voiceChannels.length);
    if(type == "FAN")
      return voiceChannels.where((c) => c.status == 1).toList();
    return voiceChannels.where((c) => c.status == 1 || c.status == 0).toList();
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<List<TextChannel>> getTextChannels(String username) async {
  try {
    return await userService.getTextChannels(username);
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<void> startCall(int concertId) async {
  try{
    await userService.startCall(concertId);
  }
  catch(e){
    print(e.toString());
  }
}

Widget ChatRooms(BuildContext context, User user) {
  return FutureBuilder(
    future: getVoiceChannels(user.username, user.type),
    builder: (context,voiceChannels) {
      if(voiceChannels.hasData){
        if (voiceChannels != null)
          return FutureBuilder(
            future: getTextChannels(user.username),
            builder: (context,textChannels) {
              if(textChannels.hasData){
                  if(textChannels != null)
                     return ListView(children: [
              ListTile(
                title: Text("Voice Calls", style: TextStyle(fontSize: 20)),
              ),
              Image.network(
                  'http://web.ist.utl.pt/ist189407/assets/images/divider.png'),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: voiceChannels.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(voiceChannels.data[index].name),
                      leading: Icon(Icons.volume_up),
                      onTap: () {
                        if (user.type == "FAN") {
                          Navigator.pushNamed(context, "/user/voicecall",
                              arguments: VoiceArguments(user, voiceChannels.data[index]));
                        } else {
                          if(voiceChannels.data[index].status == 1 )
                                 Navigator.pushNamed(context, "/user/voicecall",
                                          arguments: VoiceArguments(user, voiceChannels.data[index]));
                          else
                          {
                            showDialog(
                                context: context,
                                builder: (_) => ConfirmationDialog(
                                        "Are you sure you want to start this voice call?",
                                        "You will start a voice call with your fans.",
                                        () {
                                      startCall(voiceChannels.data[index].concertId).then((result){
                                        Navigator.of(context).pop();
                                        Navigator.pushNamed(context, "/user/voicecall",
                                          arguments: VoiceArguments(user, voiceChannels.data[index]));
                                      });
                                    
                                    }, () {
                                      Navigator.of(context).pop();
                                    }));
                          }
                        }
                      });
                },
              ),
              ListTile(
                title: Text("Chat Rooms", style: TextStyle(fontSize: 20)),
              ),
              Image.network(
                  'http://web.ist.utl.pt/ist189407/assets/images/divider.png'),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: textChannels.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(textChannels.data[index].name),
                    leading: Icon(Icons.sms),
                    onTap: () {
                      Navigator.pushNamed(context, "/user/userchat",
                          arguments: ChannelArguments(user, textChannels.data[index],false));
                    },
                  );
                },
              ),
            ]);
              }
              return Center(child: CircularProgressIndicator()); 
            } );
          
      }
      return Center(child: CircularProgressIndicator());  
    }
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
          Navigator.pushNamed(context, "/user/userProfile", arguments: ProfileArguments(user, true, null));
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
Future<User> deleteNotification(String username, String notification) async {
    try {
      return await userService.deleteNotification(username,notification);
    } catch(e) {
      print(e.toString());
      return null;
    }
}

Widget Notifications(BuildContext context, User user) {
      return ListView(
        children: [
          ListTile(
           title: Text("Notification History", style: TextStyle(fontSize: 20)),
            ),
          Image.network(
            'http://web.ist.utl.pt/ist189407/assets/images/divider.png'),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: user.notifications.length,
              itemBuilder: (context, index) {
              return ListTile(
                            title: Text(user.notifications[index]),
                            trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              deleteNotification(user.username,user.notifications[index]).then((userResult) {
                                    Navigator.popUntil(context, ModalRoute.withName("/"));
                                    Navigator.pushNamed(context, "/user/main",
                                        arguments: MainArguments(userResult,2));
                              });
                              
                            },
                            )
                           );
                      },
                    )]
     );
}

Widget MainMenu(BuildContext context, User user,int tabIndex, Widget mainPage) {
  return DefaultTabController(initialIndex: tabIndex,
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
                    tabs:  user.type == "FAN"
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
                      Notifications(context,user),
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

class Arguments {
  final User logged_in;
  final Concert concert;

  Arguments(this.logged_in, this.concert);
}

class ProfileArguments {
  final User fan;
  final bool edit;
  final User artist;
  ProfileArguments(this.fan, this.edit, this.artist);
}


class ConcertArguments {
  final Arguments arguments;
  final bool edit;
  
  ConcertArguments(this.arguments, this.edit);
}

class VoiceArguments {
  final User user;
  final VoiceChannel infoVoice;

  VoiceArguments(this.user, this.infoVoice);
}

class ChannelArguments {
  final User user;
  final TextChannel infoText;
  final bool inConcert;

  ChannelArguments(this.user, this.infoText,this.inConcert);
}

class MainArguments {
  final User user;
  final int tabInitial;
  MainArguments(this.user,this.tabInitial);
}