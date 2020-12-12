import 'package:flutter_complete_guide/models/user.dart';

class Concert {
  int id;
  String name;
  String description;
  String date;
  String image;
  String username;
  int status;
  // TextChannel textChannel;
  // VoiceChannel voiceChannel;

  Concert(int id, String name, String description, String date, String image, String username, int status) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.date = date;
    this.image = image;
    this.status = status;
    this.username = username;
    // this.textChannel = new TextChannel(this.name + " Channel");
  }

  // setVoiceChannel(VoiceChannel channel) {
  //   this.voiceChannel = channel;
  // }

  Map<String, dynamic> toJson() => {
    'name': this.name,
    'description': this.description,
    'date': this.date,
    'image': this.image,
    'id': this.id,
    'status': this.status,
    'username': this.username
  };

  factory Concert.fromJson(Map<String, dynamic> json) {
    return Concert(
      json["id"],
      json["name"],
      json["description"],
      json["date"],
      json["image"],
      json["username"],
      json["status"]
    );
  }
}