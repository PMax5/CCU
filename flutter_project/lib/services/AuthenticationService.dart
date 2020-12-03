import 'dart:convert';
import '../models/user.dart';
import 'package:flutter_complete_guide/services/Service.dart';
import "package:http/http.dart" as http;

class AuthenticationService extends Service {

  final headersPost = {
    'Content-Type': 'application/json'
  };

  Future<User> login(String username, String password) async {
    final http.Response response = await http.post(
      this.apiURL + "/user/login",
      headers: headersPost,
      body: jsonEncode(<String, dynamic> {
        'username': username,
        'password': password
      })
    );

    if (response.statusCode != 200)
      throw new Exception("Login not authorized.");

    return User.fromJson(json.decode(response.body));
  }

  Future<User> signUp(Map<String, String> formValues) async {

    Map<String, dynamic> json = {
      'username': formValues['username'],
      'email': formValues['email'],
      'password': formValues['password'],
      'type': formValues['type'],
      'name': formValues['name'],
      'imagePath': formValues['imagePath']
    };

    if (formValues['type'] == "ARTIST")
      json['description'] = formValues['description'];

    final http.Response response = await http.post(
      this.apiURL + "/user/signup",
      headers: headersPost,
      body: jsonEncode(json)
    );

    if(response.statusCode != 200)
      throw new Exception("Signup not successful.");

    json.remove('password');
    return new User.fromJson(json);
  }

}