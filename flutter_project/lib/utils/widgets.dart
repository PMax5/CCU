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

Widget CenteredProfile(String imagePath, String name) {
  return Center(
      child: Column (
        children: [
          Image.asset(imagePath),
          Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  )
              )
          )
        ],
      )
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
Widget MainMenu(BuildContext context, Widget mainPage) {
  return DefaultTabController(
    length: 4,
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
                    tabs: [
                      Tab(icon: Icon(Icons.library_music)),
                      Tab(icon: Icon(Icons.forum)),
                      Tab(icon: Icon(Icons.notifications)),
                      Tab(icon: Icon(Icons.menu))
                    ]
                )
            )
        ),
        Container(
          height: MediaQuery.of(context).size.height - 150,
          child: TabBarView(
              children: [
                mainPage,
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
                        onTap: () {
                          // TODO: change to voice call
                          Navigator.pushNamed(context, "/user/voicecall");
                        }
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
              ]
          ),
        ),
      ],
    ),
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

Widget ConcertInfoMenu(BuildContext context, String title, String description, String date, String image) {
  return MainMenu(
      context,
      Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Image.asset(image, fit: BoxFit.fill),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
                children: [
                  ListTile(
                    title: Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)
                    ),
                    subtitle: Padding(
                      padding : EdgeInsets.only(top: 6.0),
                      child: Text(
                        date,
                        style: TextStyle(fontSize: 15, color: Colors.black)
                      ),
                    ),
                    trailing: Container(
                      width: 140,
                      height: 40,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            side: BorderSide(
                                color: Colors.black,
                                width: 2
                            )
                        ),
                        child: Text(
                            'ARTIST PROFILE',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                            )
                        ),
                        onPressed: () {
                          // TODO create artist screen
                          Navigator.pushNamed(context, "/login");
                        },
                      ),
                    )
                  ),
                  ListTile(
                    title: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: const Text(
                        "About the concert",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)
                      ),
                    ),
                    subtitle: Padding(
                      padding : EdgeInsets.only(top: 6.0),
                      child: Text(
                          description,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15, color: Colors.black)
                      ),
                    ),
                  ),
                ]
            )
          ),
          // TODO change button according to state of ticket (if bought or not)
          LargeBottomButton(context, 'BUY TICKET', "/payment")
        ]
      ));
}

Widget LargeBottomButton(BuildContext context, String buttonText, String pageTo) {
  return Expanded(
      child: Align(
          alignment: FractionalOffset.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Container(
              width: 350,
              height: projectSettings.smallButtonHeight,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                color: projectSettings.mainColor,
                child: Text(
                    buttonText,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    )
                ),
                onPressed: () {
                  Navigator.pushNamed(context, pageTo);
                },
              ),
            ),
          )
      )
  );
}

Widget BackButtonLogoHeader(BuildContext context) {
  return Row(
      children: [
        IconButton(
          padding: const EdgeInsets.only(top:40, left: 8.0),
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
                child:
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: projectSettings.logo
                )
            )
        )
      ]
  );
}
