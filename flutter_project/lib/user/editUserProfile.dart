import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:flutter_complete_guide/services/UserService.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import '../settings.dart';

class EditUserProfile extends StatefulWidget {
  EditUserProfile({Key key}) : super(key: key);

  @override
  EditUserProfileState createState() => EditUserProfileState();
}

class EditUserProfileState extends State<EditUserProfile> {
  Settings projectSettings = new Settings();
  UserService userService = new UserService();
  Map<String, String> formValues = new Map<String, String>();
  User user;
  

/*  Future getImage() async{
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(){
      _image = image;
    }
  } */
/* FIXME TALVEZ POSSAMOS USAR ISTO PARA FAZER CIRCLE IMAGES EM TODO LADO
CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xffFDCF09),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('user.imagePath'),
              ),
            )


            */
  Widget buildImagePreview() {
    /*FIXME I WANT DYNAMIC PLEASE*/
    return Center(child: 
                CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(formValues["imagePath"]),
              ),
            );
  }

  Widget buildEditImageButton() {
    return Center(
      child: Container(
        width: projectSettings.textInputWidth - 180,
        height: projectSettings.textInputHeight - 20,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.black, width: 2)),
          child: Text('EDIT IMAGE',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
           onPressed: /* getImage */ () {
            //FIXME: I WANT PICKERIMAGE PLEASE
            setState(() {
              if (user.type == "FAN") {
                formValues["imagePath"] =
                    'http://web.ist.utl.pt/ist189407/assets/images/concert6.png';
              } else {
                formValues["imagePath"] =
                    'http://web.ist.utl.pt/ist189407/assets/images/concert5.png';
              }
            });
          },
        ),
      ),
    );
  }

  Widget buildNameInputField() {
    OutlineInputBorder inputBorder(Color color) {
      return OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(6.0)));
    }

    return Center(
        child: Padding(
            padding: EdgeInsets.only(bottom: 14),
            child: Container(
                width: projectSettings.textInputWidth,
                height: projectSettings.textInputHeight + 25,
                child: TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: inputBorder(Colors.black),
                        focusedBorder: inputBorder(Colors.black),
                        errorBorder: inputBorder(Colors.red),
                        focusedErrorBorder: inputBorder(Colors.red),
                        ),
                    initialValue: formValues["name"],
                    onChanged: (value) {
                      formValues["name"] = value;
                    },
                    validator: (value) {
                      if (value.isEmpty)
                        return "Enter a name for your profile";
                      return null;
                    },
                    ))));
  }

  Widget buildDescriptionInputField() {
    OutlineInputBorder inputBorder(Color color) {
      return OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(6.0)));
    }

    return Center(
        child: Padding(
            padding: EdgeInsets.only(bottom: 14),
            child: Container(
                width: projectSettings.textInputWidth,
                height: projectSettings.textInputHeight + 100,
                child: TextFormField(
                    maxLines: 5,
                    maxLength: 500,
                    decoration: InputDecoration(
                        enabledBorder: inputBorder(Colors.black),
                        focusedBorder: inputBorder(Colors.black),
                        errorBorder: inputBorder(Colors.red),
                        focusedErrorBorder: inputBorder(Colors.red),
                        ),
                    initialValue: formValues["description"],
                    onChanged: (value) {
                        formValues["description"] = value;
                    },
                    validator: (value) {
                      if (value.isEmpty)
                        return "Enter a description for your profile";
                      return null;
                    },
                    ))));
  }

  Widget buildCancelButton(BuildContext context) {
    return Container(
      width: 150,
      height: projectSettings.smallButtonHeight,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
            side: BorderSide(color: Colors.black, width: 2)),
        child: Text('CANCEL',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget buildSaveButton(BuildContext context, GlobalKey<FormState> key) {
    return Container(
      width: 150,
      height: projectSettings.smallButtonHeight,
      child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
          ),
          color: projectSettings.mainColor,
          child: Text('SAVE',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          onPressed: () {
            if (key.currentState.validate()) {
              editProfile().then((newUser) {
                if (newUser != null) {
                  Navigator.popUntil(context, ModalRoute.withName("/"));
                  Navigator.pushNamed(
                      context, "/user/main", arguments: newUser);
                  Navigator.pushNamed(context, "/user/userProfile",
                      arguments: ProfileArguments(newUser, true));
                } else {
                  showDialog(
                      context: context,
                      builder: (_) =>
                          TipDialog("Notice",
                              "Sorry try to update you profile in a few minutes.",
                                  () {
                                Navigator.of(context).pop();
                              }));
                }
              });
            }
          }),
    );
  }

  Widget buildForm(BuildContext context) {
    final EditUserProfileFormKey = GlobalKey<FormState>();

    if(formValues.isEmpty) {
      formValues["username"] = user.username;
      formValues["email"] = user.email;
      formValues["name"] = user.name;
      formValues["imagePath"] = user.imagePath;
      formValues["type"] = user.type;
      formValues["description"] = user.description;
    }

    return Padding(
      padding: EdgeInsets.only(top: 48),
      child: Form(
        key: EditUserProfileFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: buildImagePreview(),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: buildEditImageButton(),
            ),
            buildNameInputField(),
            (user.type == 'ARTIST'
                ? buildDescriptionInputField()
                : Container()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: buildCancelButton(context)),
                buildSaveButton(context, EditUserProfileFormKey)
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<User> editProfile() async {
    try {
      User user_result = await userService.updateUser(
          this.user.username,
          formValues["name"],
          formValues["imagePath"],
          this.user.type == "ARTIST" ? formValues["description"] : null);
      return user_result;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    user = ModalRoute.of(context).settings.arguments;
    // File _image;
    return Scaffold(
      appBar: AppBar(
          title: Text("Edit Profile"),
          backgroundColor: projectSettings.mainColor),
      body: SingleChildScrollView(child: this.buildForm(context)),
    );
  }
}
