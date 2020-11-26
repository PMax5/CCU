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