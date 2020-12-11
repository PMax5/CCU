import 'dart:convert';

import 'package:flutter_complete_guide/models/user.dart';
import 'package:flutter_complete_guide/services/Service.dart';
import "package:http/http.dart" as http;

class UserService extends Service {

  Future<User> updateUser(String username, String newName, String newImagePath, String newDescription) async {
    final http.Response response = await http.put(
      this.apiURL + "/user/${username}/update",
      headers: this.headersPost,
      body: jsonEncode(<String, dynamic> {
        'name': newName,
        'imagePath': newImagePath,
        'description': newDescription
      })
    );

    if (response.statusCode != 200)
      throw new Exception("Could not update user with username=${username}.");

    var userJson = json.decode(response.body);
    User user2 = User.fromJson(userJson);
    user2.password = null;
    return user2;
  }

  Future<User> follow(String username, String artistname) async {
    final http.Response response = await http.post(
      this.apiURL + "/user/${username}/follow",
      headers: this.headersPost,
      body: jsonEncode(<String, dynamic> {
        'username': artistname
      })
    );

    if (response.statusCode != 200)
      throw new Exception("Could not follow user with username=${artistname}.");

    var userJson = json.decode(response.body);
    User user2 = User.fromJson(userJson);
    user2.password = null;
    return user2;
  }

  Future<User> unfollow(String username, String artistname) async {
    final http.Response response = await http.post(
      this.apiURL + "/user/${username}/unfollow",
      headers: this.headersPost,
      body: jsonEncode(<String, dynamic> {
        'username': artistname
      })
    );

    if (response.statusCode != 200)
      throw new Exception("Could not follow user with username=${artistname}.");

    var userJson = json.decode(response.body);
    User user2 = User.fromJson(userJson);
    user2.password = null;
    return user2;
  }

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