import 'dart:convert';

import 'package:flutter_complete_guide/models/concert.dart';
import 'package:flutter_complete_guide/services/Service.dart';
import "package:http/http.dart" as http;

class ConcertService extends Service {

  Future<Concert> createConcert(Map<String, String> formValues, String username) async {
    final http.Response response = await http.post(
        this.apiURL + "/artist/$username/concerts/new",
        headers: this.headersPost,
        body: jsonEncode(formValues)
    );

    if (response.statusCode != 200)
      throw new Exception("Could not create concert.");

    return Concert.fromJson(formValues);
  }

  Future<void> updateConcert(Concert concert, String username) async {
    final http.Response response = await http.put(
      this.apiURL + "/artist/$username/concerts/${concert.id}/update",
      headers: this.headersPost,
      body: jsonEncode(concert.toJson())
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

  Future<bool> startConcert(String username, int id) async {
    final http.Response response = await http.post(
      this.apiURL + "/artist/$username/concerts/$id/start",
      headers: this.headersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not start concert with id=$id.");
    else
      return true;
  }

  Future<bool> endConcert(String username, int id) async {
    final http.Response response = await http.post(
      this.apiURL + "/artist/$username/concerts/$id/end",
      headers: this.headersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not end concert with id=$id.");
    else
      return true;
  }

  Future<VoiceChannel> startVoiceCall(String username, int id) async {
    final http.Response response = await http.post(
      this.apiURL + "/artist/$username/concerts/$id/startVoiceCall",
      headers: this.headersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not start voice call associated with concert id=$id.");

    return VoiceChannel.fromJson(json.decode(response.body));
  }

  Future<bool> endVoiceCall(String username, int id) async {
    final http.Response response = await http.post(
        this.apiURL + "/artist/$username/concerts/$id/endVoiceCall",
        headers: this.headersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not start voice call associated with concert id=$id.");
    else
      return true;
  }

}