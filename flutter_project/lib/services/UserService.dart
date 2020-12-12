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
      this.apiURL + "/user/${username}/follow/${artistname}",
      headers: this.headersPost
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
      this.apiURL + "/user/${username}/unfollow/${artistname}",
      headers: this.headersPost

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

    if (response.statusCode != 200)
      throw new Exception("Could not get user with username=${username}.");

    var userJson = json.decode(response.body);
    User user = User.fromJson(userJson);
    user.password = null;
    return user;
  }
  Future<List<TextChannel>> getTextChannels(String username) async {
    final http.Response response = await http.get(
        this.apiURL + "/user/${username}/channels",
        headers: this.headersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not get textChannels with username=${username}.");

    var channelsJson = json.decode(response.body) as List;
    List<TextChannel> channels = channelsJson.map((channelJson) => TextChannel.fromJson(channelJson)).toList();
    return channels;
  }

  Future<List<VoiceChannel>> getVoiceChannels(String username) async {
  final http.Response response = await http.get(
        this.apiURL + "/user/${username}/voiceChannels",
        headers: this.headersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not get voiceChannels with username=${username}.");

    var voiceChannelsJson = json.decode(response.body) as List;
    List<VoiceChannel> voiceChannels = voiceChannelsJson.map((voiceChannelJson) => TextChannel.fromJson(voiceChannelJson)).toList();
    return voiceChannels;
  }
  Future<void> startCall(int concertId) async {
     final http.Response response = await http.put(
        this.apiURL + "/concert/${id}/startCall",
        headers: this.headersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not start voiceCall with concertId=${id}.");
  }
  Future<void> endCall (int concertId) async {
     final http.Response response = await http.put(
        this.apiURL + "/concert/${id}/endCall",
        headers: this.headersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not end voiceCall with concertId=${id}.");
  }
}