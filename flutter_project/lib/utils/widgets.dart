import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user.dart';
import 'package:flutter_complete_guide/settings.dart';
import 'package:flutter_complete_guide/models/user.dart';

Settings projectSettings = new Settings();
List<String> channelNames = List<String>();

Widget CenteredHeaderLogo() {
  return Center(child: projectSettings.logo);
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

