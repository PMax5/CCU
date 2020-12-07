
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:flutter_complete_guide/services/AuthenticationService.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import '../settings.dart';

class SignUpProfile extends StatefulWidget {
  SignUpProfile({Key key}) : super(key: key);

  @override
  SignUpProfileState createState() => SignUpProfileState();
}

class SignUpProfileState extends State<SignUpProfile> {

  Settings projectSettings = new Settings();
  AuthenticationService authenticationService = new AuthenticationService();
  Map<String, String> formValues;
  String profileImagePath = 'http://web.ist.utl.pt/ist189407/assets/images/profile_general.png';

  Widget buildImagePreview() {
    Image profileImage = Image.network(profileImagePath, fit: BoxFit.cover);
    formValues["imagePath"] = profileImagePath;

    return Center(
        child: profileImage
    );
  }

  Widget buildEditImageButton() {
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
            //TODO: this works kinda weird, fix later
            setState(() {
              if (formValues["type"] == "FAN")
                profileImagePath = 'http://web.ist.utl.pt/ist189407/assets/images/profile_fan.png';
              else
                profileImagePath = 'http://web.ist.utl.pt/ist189407/assets/images/james.png';
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
                        hintText: "Name"
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

  Widget buildDescriptionInputField() {
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
                        hintText: "Description"
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

  Widget buildSaveButton(BuildContext context, GlobalKey<FormState> key, String type) {
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
                    signup().then((user) {
                      if (user != null) {
                        Navigator.popUntil(context, ModalRoute.withName("/"));
                        Navigator.pushNamed(
                            context,
                            "/user/main",
                            arguments: user
                        );
                      }
                      else {
                        showDialog(
                            context: context,
                            builder: (_) => TipDialog(
                                "Notice",
                                "E-mail or username already taken.",
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

  Widget buildFanForm(BuildContext context) {
    final signUpProfileFormKey = GlobalKey<FormState>();

    return Padding(
      padding: EdgeInsets.only(top: 48),
      child: Form(
        key: signUpProfileFormKey,
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
            this.buildNameInputField(),
            this.buildSaveButton(context, signUpProfileFormKey, "FAN")
          ],
        ),
      ),
    );
  }

  Widget buildArtistForm(BuildContext context) {
    final signUpProfileFormKey = GlobalKey<FormState>();

    return Padding(
      padding: EdgeInsets.only(top: 48),
      child: Form(
        key: signUpProfileFormKey,
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
            this.buildNameInputField(),
            this.buildDescriptionInputField(),
            this.buildSaveButton(context, signUpProfileFormKey, "FAN")
          ],
        ),
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    formValues = ModalRoute.of(context).settings.arguments;

    if (formValues["type"] == "FAN") return buildFanForm(context);
    else return buildArtistForm(context);
  }

  Future<User> signup() async {
    try {
      if (formValues["type"] == "FAN") {
        formValues["description"] = "";
      }
      User user = await authenticationService.signUp(formValues);
      return user;
    } catch(e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("User Profile"),
          backgroundColor: projectSettings.mainColor
      ),
      body:SingleChildScrollView(
          child: this.buildForm(context)
      ),
    );
  }
}

