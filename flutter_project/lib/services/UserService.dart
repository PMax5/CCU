import 'dart:convert';

import 'package:flutter_complete_guide/models/user.dart';
import 'package:flutter_complete_guide/services/Service.dart';
import "package:http/http.dart" as http;

class UserService extends Service {

  Future<User> updateUser(User user) async {
    final http.Response response = await http.post(
      this.apiURL + "/user/${user.username}/update",
      headers: this.headersPost,
      body: jsonEncode(user.toJson())
    );

    if (response.statusCode != 200)
      throw new Exception("Could not update user with username=${user.username}.");

    user.password = null;
    return user;
  }

}