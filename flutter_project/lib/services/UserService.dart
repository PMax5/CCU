import 'dart:convert';

import 'package:flutter_complete_guide/models/user.dart';
import 'package:flutter_complete_guide/services/Service.dart';
import "package:http/http.dart" as http;

class UserService extends Service {

  
  Future<User> getUser(String username) async {
    final http.Response response = await http.get(
        this.apiURL + "/user/${username}",
        headers: this.headersPost
    );

    print(response.statusCode);

    print(response.body);
    if (response.statusCode != 200)
      throw new Exception("Could not get user with username=${username}.");

    var userJson = json.decode(response.body);
    User user = User.fromJson(userJson);
    user.password = null;
    return user;
  }

}