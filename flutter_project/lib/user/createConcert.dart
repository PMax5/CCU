import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/concert.dart';
import 'package:flutter_complete_guide/services/ConcertService.dart';
import 'package:flutter_complete_guide/utils/widgets.dart';
import '../settings.dart';

class CreateConcert extends StatefulWidget {
  CreateConcert({Key key}) : super(key: key);

  @override
  CreateConcertState createState() => CreateConcertState();
}

class CreateConcertState extends State<CreateConcert> {
  Settings projectSettings = new Settings();
  ConcertService concertService = new ConcertService();
  final createConcertFormKey = GlobalKey<FormState>();
  Map<String, String> formValues = new Map<String, String>();

  DateTime selectedDateTime = DateTime.now();

  Widget buildImagePreview() {
    return Center(
      child: Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Image(
            image: AssetImage(formValues["image"]),
            fit: BoxFit.cover,
          )),
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
          onPressed: () {
            //FIXME: I WANT PICKERIMAGE PLEASE
            setState(() {
                formValues["image"] =
                    'https://rentalandstaging.net/wp-content/uploads/2015/11/rsn-stage-lights.jpg';
              
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
            padding: EdgeInsets.only(bottom: 1),
            child: Container(
                width: projectSettings.textInputWidth + 40,
                height: projectSettings.textInputHeight + 25,
                child: TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: inputBorder(Colors.black),
                        focusedBorder: inputBorder(Colors.black),
                        errorBorder: inputBorder(Colors.red),
                        focusedErrorBorder: inputBorder(Colors.red),
                        hintText: "Concert Name"),
                    validator: (value) {
                      if (value.isEmpty)
                        return "Enter a name for your concert";
                      else {
                        formValues["name"] = value;
                        return null;
                      }
                    }))));
  }

  Widget buildDateInputField(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        height: projectSettings.textInputHeight,
        child: OutlineButton(
          child: Text(
            "${selectedDateTime.toLocal()}".split(' ')[0],
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          color: Colors.white,
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          onPressed: () {
            selectDate(context);
            String year = "${selectedDateTime.year.toString()}";
            String month =
                "${selectedDateTime.month.toString().padLeft(2, '0')}";
            String day = "${selectedDateTime.day.toString().padLeft(2, '0')}";
            String hours = "${selectedDateTime.hour.toString()}";
            String minutes = "${selectedDateTime.minute.toString()}";
            String date =
                day  + "-" + month + "-" + year + " " + hours + ":" + minutes;
            print(date);
            formValues["date"] = date;
          },
        ),
      ),
    );
  }

  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2020, 12),
      lastDate: DateTime(2050),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: createMaterialColor(projectSettings.mainColor),
              primaryColorDark: createMaterialColor(projectSettings.mainColor),
              accentColor: createMaterialColor(projectSettings.mainColor),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDateTime)
      setState(() {
        selectedDateTime = picked;
      });
  }

  Widget buildHourInputField(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        height: projectSettings.textInputHeight,
        child: OutlineButton(
          child: Text(
            "${selectedDateTime.hour.toString()}:${selectedDateTime.minute.toString()}",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          color: Colors.white,
          borderSide: BorderSide(color: Colors.black, width: 2.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          onPressed: () {
            selectTime(context);
            String year = "${selectedDateTime.year.toString()}";
            String month =
                "${selectedDateTime.month.toString().padLeft(2, '0')}";
            String day = "${selectedDateTime.day.toString().padLeft(2, '0')}";
            String hours = "${selectedDateTime.hour.toString()}";
            String minutes = "${selectedDateTime.minute.toString()}";
            String date =
                year + "-" + month + "-" + day + " " + hours + ":" + minutes;
            print(date);
            formValues["date"] = date;
          },
        ),
      ),
    );
  }

  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      builder: (BuildContext context, Widget child) {
        return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: createMaterialColor(projectSettings.mainColor),
                primaryColorDark:
                    createMaterialColor(projectSettings.mainColor),
                accentColor: createMaterialColor(projectSettings.mainColor),
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child,
            ));
      },
    );
    if (picked != null && picked != TimeOfDay.fromDateTime(selectedDateTime))
      setState(() {
        selectedDateTime = DateTime(
            selectedDateTime.year,
            selectedDateTime.month,
            selectedDateTime.day,
            picked.hour,
            picked.minute);
      });
  }

  Widget buildDescriptionField() {
    OutlineInputBorder inputBorder(Color color) {
      return OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(6.0)));
    }

    return Center(
        child: Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Container(
                width: projectSettings.textInputWidth + 40,
                height: projectSettings.textInputHeight + 30,
                child: TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                        enabledBorder: inputBorder(Colors.black),
                        focusedBorder: inputBorder(Colors.black),
                        errorBorder: inputBorder(Colors.red),
                        focusedErrorBorder: inputBorder(Colors.red),
                        hintText: "Description"),
                    validator: (value) {
                      if (value.isEmpty)
                        return "Enter a description for your concert";
                      else {
                        formValues["description"] = value;
                        return null;
                      }
                    }))));
  }


  Widget buildCancelButton(BuildContext context, User user) {
    return Center(
      child: Container(
        width: 170,
        height: projectSettings.textInputHeight,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.black, width: 2)),
          child: Text('CANCEL',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
          onPressed: () {
            Navigator.pop();
          },
        ),
      ),
    );
  }

  Widget buildCreateButton(
      BuildContext context, GlobalKey<FormState> key, User user) {
    return Center(
        child: Container(
            width: 170,
            height: projectSettings.textInputHeight,
            child: ElevatedButton(
                child: Text("CREATE",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      projectSettings.mainColor),
                ),
                onPressed: () {
                  if (key.currentState.validate()) {
                    createConcert(user).then((concert) {
                      if (concert) {
                        Navigator.popUntil(context, ModalRoute.withName("/"));
                        Navigator.pushNamed(context, "/user/main",
                            arguments: user);
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) => TipDialog("Notice",
                                    "Something went wrong, check your inserted information.",
                                    () {
                                  Navigator.of(context).pop();
                                }));
                      }
                    });
                  }
                })));
  }

  Widget concertCreationForm(BuildContext context, User user) {
    return Form(
          key: createConcertFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildImagePreview(),
              buildEditImageButton,
              buildNameInputField(),
              Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildDateInputField(context),
                      buildHourInputField(context),
                    ]),
              ),
              buildDescriptionField(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildCancelButton(context, user),
                  buildCreateButton(context, createConcertFormKey, user)
                ],
              ),
            ],
          ),
        );
  }

  Future<bool> createConcert(User user) async {
    try {
       await concertService.createConcert(formValues, user.username);
       return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
          r + ((ds < 0 ? r : (255 - r)) * ds).round(),
          g + ((ds < 0 ? r : (255 - g)) * ds).round(),
          b + ((ds < 0 ? r : (255 - b)) * ds).round(),
          1);
    });
    return MaterialColor(color.value, swatch);
  }

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;
    if (formValues == null)
    {
      formValues["username"] = user.username;
      formValues["image"] = "http://web.ist.utl.pt/ist189407/assets/images/concert_placeholder.png";
    }

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
      BackButtonLogoHeader(context),
      concertCreationForm(context, user)
    ])));
  }
}
