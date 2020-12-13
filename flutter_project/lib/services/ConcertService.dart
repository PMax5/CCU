import 'dart:convert';
import 'package:flutter_complete_guide/models/concert.dart';
import 'package:flutter_complete_guide/services/Service.dart';
import 'package:flutter_complete_guide/models/user.dart';
import "package:http/http.dart" as http;

class ConcertService extends Service {

  Future<void> createConcert(Map<String, String> formValues, String username) async {
    final http.Response response = await http.post(
        this.apiURL + "/artist/$username/concerts/new",
        headers: this.headersPost,
        body: jsonEncode(formValues)
    );

    if (response.statusCode != 200)
      throw new Exception("Could not create concert.");

  }

  Future<void> updateConcert(Map<String, String> formValues, int concertId) async {
    final http.Response response = await http.put(
        this.apiURL + "/concerts/$concertId/update",
        headers: this.headersPost,
        body: jsonEncode(formValues)
    );

    if (response.statusCode != 200)
      throw new Exception("Could not update concert.");

  }
  Future<List<Concert>> getAllConcerts() async {
    final http.Response response = await http.get(
      this.apiURL + "/concerts",
      headers: this.requestHeadersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not get all the concerts.");

    var concertsJson = json.decode(response.body) as List;
    List<Concert> concerts = concertsJson.map((concertJson) => Concert.fromJson(concertJson)).toList();
    return concerts;
  }

  Future<List<Concert>> getArtistConcerts(String username) async {
    final http.Response response = await http.get(
        this.apiURL + "/artist/$username/concerts",
        headers: this.requestHeadersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not get concerts for artist with username=$username.");

    var concertsJson = json.decode(response.body) as List;
    List<Concert> concerts = concertsJson.map((concertJson) => Concert.fromJson(concertJson)).toList();
    return concerts;
  }


 Future<User> returnTicket(String username, int id) async {
    final http.Response response = await http.post(
        this.apiURL + "/user/$username/concerts/$id/returnTicket",
        headers: this.headersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not return ticket from the concert.");
    var userJson = json.decode(response.body);
    User user = User.fromJson(userJson);
    user.password = null;
    return user;
  }

  Future<User> purchaseTicket(String username, int id) async {
    final http.Response response = await http.post(
      this.apiURL + "/user/$username/concerts/$id/purchaseTicket",
      headers: this.headersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not purchase ticket for concert with id=$id.");
    var userJson = json.decode(response.body);
    User user = User.fromJson(userJson);
    user.password = null;
    return user;
  }

  Future<void> startConcert(String username, int id) async {
    final http.Response response = await http.post(
      this.apiURL + "/artist/$username/concerts/$id/start",
      headers: this.headersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not start concert with id=$id.");
  }

  Future<void> cancelConcert(String username, int id) async {
    final http.Response response = await http.post(
      this.apiURL + "/artist/$username/concerts/$id/cancel",
      headers: this.headersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not end concert with id=$id.");
  }
  
  Future<void> endConcert(String username, int id) async {
    final http.Response response = await http.post(
      this.apiURL + "/artist/$username/concerts/$id/end",
      headers: this.headersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not end concert with id=$id.");
  }

  Future<List<Message>> getConcertMessages(int id) async {
    final http.Response response = await http.get(
      this.apiURL + "/concerts/$id/messages",
      headers: this.headersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not get messages for concert with id=$id.");

    var messagesJson = json.decode(response.body);
    List<Message> messages = messagesJson.map<Message>((messageJson) => Message.fromJson(messageJson)).toList();
    return messages;
  }

  Future<List<Message>> sendMessage(int id, Message message) async {
    final http.Response response = await http.post(
      this.apiURL + "/concerts/$id/sendMessage",
      headers: this.headersPost,
      body: jsonEncode(message)
    );

    if (response.statusCode != 200)
      throw new Exception("Could not send message for concert with id=$id.");

    var messagesJson = json.decode(response.body);
    List<Message> messages = messagesJson.map<Message>((messageJson) => Message.fromJson(messageJson)).toList();
    return messages;
  }
  
}