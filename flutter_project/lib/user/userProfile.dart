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
  bool edit;
  bool follow;
  bool followupdate = null;
  Widget buildEditButton(BuildContext context) {
    return Center(
      child: Container(
        width: 120,
        height: 35,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.black, width: 2)),
          child: Text(edit ? 'EDIT' : follow ? 'UNFOLLOW': 'FOLLOW' ,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          onPressed: () {
            if (edit)
              Navigator.pushNamed(context, "/user/editProfile", arguments: user);
            else {
            //FIXME I NEED TO UPDATE SERVER WITH THE FOLLOW OR UNFOLLOW
              setState( () {
              followupdate = !follow;
            }); 
            }
          },
        ),
      ),
    );
  }

  Widget buildDescription(User user) {
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
          child: Text(user.description,
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
                backgroundImage: NetworkImage(user.imagePath),
                ),
              ),
          ),
          Center(
              child: Text(user.name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))),
          Padding(
            padding: EdgeInsets.only(top: 30, bottom: 30),
            child: buildEditButton(context),
          ),
          (user.type == 'ARTIST' ? buildDescription(user) : Container())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ProfileArguments profileArguments = ModalRoute.of(context).settings.arguments;
    user = profileArguments.user;
    edit = profileArguments.edit;
    if (followupdate == null)
     follow = false; //FIXME this need to come from server
    else
      follow = followupdate;
    return Scaffold(
      appBar: AppBar(
          title: Text("User Profile"),
          backgroundColor: projectSettings.mainColor),
      body: SingleChildScrollView(child: this.buildProfilePage(context)),
    );
  }
}
