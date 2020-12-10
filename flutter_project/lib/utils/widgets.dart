import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/user.dart';
import 'package:flutter_complete_guide/settings.dart';
import 'package:flutter_complete_guide/models/user.dart';
import '../models/concert.dart';

Settings projectSettings = new Settings();
List<String> channelNames = List<String>();

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

class Arguments {
  final User logged_in;
  final Concert concert;

  Arguments(this.logged_in, this.concert);
}

class ProfileArguments {
  final User user;
  final bool edit;

  ProfileArguments(this.user, this.edit);
}