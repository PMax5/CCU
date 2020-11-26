import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_complete_guide/settings.dart';

Settings projectSettings = new Settings();

Widget CenteredHeaderLogo() {
  return Center(
      child: projectSettings.logo
  );
}

Widget FormInputField(String hintText, String invalidInputMessage, int maxCharacters) {
  OutlineInputBorder inputBorder(Color color) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(6.0))
    );
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
                      hintText: hintText
                  ),
                  validator: (value) {
                    if (value.isEmpty)
                      return invalidInputMessage;
                    return null;
                  }
              )
          )
      )
  );
}

Widget MainMenu() {
  return DefaultTabController(
      length: 4,
      child: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.library_music)),
          Tab(icon: Icon(Icons.forum)),
          Tab(icon: Icon(Icons.notifications)),
          Tab(icon: Icon(Icons.menu))
        ],
        //TODO: Finish this. This needs to be a Scaffold.
      )
  );
}

Widget ConfirmationDialog(String title, String content, Function onConfirm, Function onBack) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: <Widget>[
      RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
            side: BorderSide(
                color: Colors.black,
                width: 2
            )
        ),
        child: Text(
            'BACK',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black
            )
        ),
        onPressed: onBack
      ),
      ElevatedButton(
          child: Text(
              "CONFIRM",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              )
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(projectSettings.mainColor),
          ),
          onPressed: onConfirm
      )
    ]
  );
}

Widget TipDialog(String title, String description, Function onOK) {
  return AlertDialog(
    title: Text(title),
    content: Text(description),
      actions: <Widget>[
        ElevatedButton(
            child: Text(
                "OK",
                style: TextStyle(
                    fontWeight: FontWeight.bold
                )
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(projectSettings.mainColor),
            ),
            onPressed: onOK
        )
      ]
  );
}
