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
}