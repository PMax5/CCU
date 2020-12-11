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

  Future<void> purchaseTicket(String username, int id) async {
    final http.Response response = await http.post(
      this.apiURL + "/user/$username/concerts/$id/purchaseTicket",
      headers: this.headersPost
    );

    if (response.statusCode != 200)
      throw new Exception("Could not purchase ticket for concert with id=$id.");
  }

  
}