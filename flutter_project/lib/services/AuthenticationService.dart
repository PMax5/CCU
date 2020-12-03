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

    print(response.statusCode);
    if(response.statusCode == 403)
      print("HAHAHAHAH");

    if (response.statusCode != 200)
      throw new Exception("Login not authorized.");

    return User.fromJson(json.decode(response.body));
  }

}