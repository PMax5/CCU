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
Widget MainMenu(BuildContext context) {
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
                ListView(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 5,
                      child: new InkWell(
                        onTap: () {  //TODO: ecra com info do concerto 
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
                Text("Test")
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
                ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Image.asset(image, fit: BoxFit.fill),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                /*width: projectSettings.smallButtonWidth,
                                height: projectSettings.smallButtonHeight,*/
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
                            Padding(
                                // FIXME this padding only serves for the first example
                                padding: EdgeInsets.only(top: 100),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: 350,
                                    height: projectSettings.smallButtonHeight,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(5.0),
                                      ),
                                      color: projectSettings.mainColor,
                                      child: Text(
                                          'BUY TICKET',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                          )
                                      ),
                                      onPressed: () {
                                        Navigator.pushNamed(context, "/payment");
                                      },
                                    ),
                                  )
                                ),
                            )
                          ]
                      )
                    ),
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
                Text("Test")
              ]
          ),
        ),
      ],
    ),
  );
}