import 'dart:convert';
import '../models/user.dart';
import 'package:flutter_complete_guide/services/Service.dart';
import "package:http/http.dart" as http;

class AuthenticationService extends Service {

  Future<User> login(String username, String password) async {
    final http.Response response = await http.post(
      this.apiURL + "/user/login",
      headers: this.headersPost,
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

    Map<String, dynamic> ajson = {
      'username': formValues['username'],
      'email': formValues['email'],
      'password': formValues['password'],
      'type': formValues['type'],
      'name': formValues['name'],
      'imagePath': formValues['imagePath'],
      'description': formValues['description']
    };

    /*if (formValues['type'] == "ARTIST")
      json['description'] = formValues['description'];*/

    final http.Response response = await http.post(
      this.apiURL + "/user/signup",
      headers: this.headersPost,
      body: jsonEncode(ajson)
    );

    if(response.statusCode != 200)
      throw new Exception("Signup not successful.");
    
    var userJson = json.decode(response.body);
    User user = User.fromJson(userJson);
    user.password = null;
    return user;
  }

}