import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/services/UserService.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import '../models/user.dart';
import '../settings.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key key}) : super(key: key);

  @override
  UserProfileState createState() => UserProfileState();
}
class UserProfileState extends State<UserProfile> {
  Settings projectSettings = new Settings();
  UserService userService = new UserService();
  User user;
  User userUpdated;
  bool edit;
  User artist;
  bool follow;
  Widget buildEditButton(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        height: 35,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              side: edit ? BorderSide(color: Colors.black, width: 2) : follow ? BorderSide(width:0) : BorderSide(color: Colors.black, width: 2)),
          color: edit ? null : follow ?  projectSettings.mainColor  : null,
          child: Text(edit ? 'EDIT' : follow ? 'UNFOLLOW': 'FOLLOW' ,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: edit ? Colors.black : follow ?  Colors.white :  Colors.black )),
          onPressed: () {
            if (edit)
              Navigator.pushNamed(context, "/user/editProfile", arguments: user);
            else {
              updatefollow().then((newUser) {
                if (newUser != null) {
                  setState( () {
                    userUpdated = newUser;
                  }); 
                } else {
                  showDialog(
                      context: context,
                      builder: (_) =>
                          TipDialog("Notice",
                              "Sorry try to unfollow or follow the artist in a few minutes.",
                                  () {
                                Navigator.of(context).pop();
                              }));
                }
              });             
            }
          },
        ),
      ),
    );
  }

  Widget buildDescription(User userDescription) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ListTile(
        title: Padding(
          padding: EdgeInsets.only(top: 15.0),
          child: const Text("Description",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: Colors.black)),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 6.0),
          child: Text(userDescription.description,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18, color: Colors.black)),
        ),
      ),
    );
  }

  Widget buildProfilePage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Center(
                child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(edit == true ? user.imagePath:artist.imagePath),
                ),
              ),
          ),
          Center(
              child: Text(edit == true ? user.name : artist.name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))),
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 30),
            child: buildEditButton(context),
          ),
          (edit ? user.type == 'ARTIST' ? buildDescription(user) : Container() : artist.type == "ARTIST" ? buildDescription(artist): Container())
        ],
      ),
    );
  }

  Future<User> updatefollow() async {
    try {
      User user_result;
      if (follow)
        user_result = await userService.unfollow(user.username,artist.username);
      else
        user_result = await userService.follow(user.username,artist.username);
      return user_result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    ProfileArguments profileArguments = ModalRoute.of(context).settings.arguments;
    edit = profileArguments.edit;
    if(!edit)
    {
      artist = profileArguments.artist;

      if(userUpdated == null)
        user = profileArguments.fan;
      else
        user = userUpdated;

      if(user.favorites.contains(artist.username))
        follow = true;
      else
        follow = false;

    }
    else
      user = profileArguments.fan;
    return Scaffold(
      appBar: AppBar(
          title: Text("User Profile"),
          backgroundColor: projectSettings.mainColor),
      body: SingleChildScrollView(child: this.buildProfilePage(context)),
    );
  }
}
