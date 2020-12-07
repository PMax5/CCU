
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
  Map<String, String> formValues;
  String profileImagePath = '';

  Widget buildImagePreview(user) { /*FIXME I WANT DYNAMIC PLEASE*/
   profileImagePath = user.imagePath;
   Image profileImage = Image.asset(profileImagePath, fit: BoxFit.cover);
   formValues["imagePath"] = profileImagePath;

    return Center(
        child: profileImage
    );
  }

  Widget buildEditImageButton(user) {
    return Center(
      child: Container(
        width: projectSettings.textInputWidth - 180,
        height: projectSettings.textInputHeight - 20,
        child: ElevatedButton(
          child: Text(
            "EDIT IMAGE",
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(200, 200, 200, 0.8))
          ),
          onPressed: () {
            //FIXME: I WANT PICKERIMAGE PLEASE
            setState(() {
              if (user.type == "FAN")
                profileImagePath = 'assets/images/concert6.png';
              else
                profileImagePath = 'assets/images/concert5.png';
            });
          },
        ),
      ),
    );
  }

  Widget buildNameInputField(user) {

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
                width: projectSettings.textInputWidth,
                height: projectSettings.textInputHeight + 25,
                child: TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: inputBorder(Colors.black),
                        focusedBorder: inputBorder(Colors.black),
                        errorBorder: inputBorder(Colors.red),
                        focusedErrorBorder: inputBorder(Colors.red),
                        hintText: user.name
                    ),
                    validator: (value) {
                      if (value.isEmpty)
                        return "Enter a name for your profile";
                      else {
                        formValues["name"] = value;
                        return null;
                      }
                    }
                )
            )
        )
    );
  }

  Widget buildDescriptionInputField(user) {
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
                        hintText: user.description
                    ),
                    validator: (value) {
                      if (value.isEmpty)
                        return "Enter a description for your profile";
                      else {
                        formValues["description"] = value;
                        return null;
                      }
                    }
                )
            )
        )
    );
  }
  Widget buildCancelButton(BuildContext context){
	return Center(
	        child: Container(
	            width: projectSettings.textInputWidth,
	            height: projectSettings.textInputHeight,
	            child: ElevatedButton(
	                child: Text(
	                    "Cancel",
	                    style: TextStyle(
	                        fontWeight: FontWeight.bold
	                    )
	                ),
	                style: ButtonStyle(
	                  backgroundColor: MaterialStateProperty.all<Color>(projectSettings.mainColor),
	                ),
	                onPressed: () {
                        Navigator.pop(context);
	                }
	            )
	        )
	    );


  }
  Widget buildSaveButton(BuildContext context, GlobalKey<FormState> key) {
    return Center(
        child: Container(
            width: projectSettings.textInputWidth,
            height: projectSettings.textInputHeight,
            child: ElevatedButton(
                child: Text(
                    "Save",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    )
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(projectSettings.mainColor),
                ),
                onPressed: () {
                  if (key.currentState.validate()) {
                    editProfile().then((user) {
                      if (user != null) {
                        Navigator.pop(context,user);
                      }
                      else {
                        showDialog(
                            context: context,
                            builder: (_) => TipDialog(
                                "Notice",
                                "Sorry try to update you profile in a few minutes.",
                                    () {
                                  Navigator.of(context).pop();
                                }
                            )
                        );
                      }
                    });
                  }
                }
            )
        )
    );
  }

  Widget buildForm(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;
    final EditUserProfileFormKey = GlobalKey<FormState>();

    return Padding(
      padding: EdgeInsets.only(top: 48),
      child: Form(
        key: EditUserProfileFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: buildImagePreview(user),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: buildEditImageButton(user),
            ),
            buildNameInputField(user),
            (user.type == 'ARTIST' ? buildDescriptionInputField(user) : Container()),
            buildCancelButton(context),
            buildSaveButton(context, EditUserProfileFormKey)
          ],
        ),
      ),
    );
  }

  Future<User> editProfile() async {
    try {
      if (formValues["type"] == "FAN") {
        formValues["description"] = "";
      }
      User user = await userService.updateUser(formValues);
      return user;
    } catch(e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Edit Profile"),
          backgroundColor: projectSettings.mainColor
      ),
      body:SingleChildScrollView(
          child: this.buildForm(context)
      ),
    );
  }
}

