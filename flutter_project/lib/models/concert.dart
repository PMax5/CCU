import 'package:flutter_complete_guide/models/user.dart';

class Concert {
  int id;
  String name;
  String description;
  String date;
  String link;
  String image;
  String username;
  int status;
  TextChannel textChannel;
  VoiceChannel voiceChannel;

  Concert(int id, String name, String description, String date, String link, String image, String username, int status) {
    this.id = id;
    this.name = name;
    this.description = description;
    this.date = date;
    this.link = link;
    this.image = image;
    this.status = status;
    this.username = username;
    this.textChannel = new TextChannel(this.name + " Channel");
  }

  setVoiceChannel(VoiceChannel channel) {
    this.voiceChannel = channel;
  }

  Map<String, dynamic> toJson() => {
    'name': this.name,
    'description': this.description,
    'date': this.date,
    'link': this.link,
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
      json["link"],
      json["image"],
      json["username"],
      json["status"]
    );
  }
}

class TextChannel {
  String name;
  List<Message> messages;

  TextChannel(String name) {
    this.name = name;
  }

  void loadTextMessages(List<Message> messages) {
    this.messages = messages;
  }
}

class VoiceChannel {
  String name;
  List<String> participants;
  int concertId;

  VoiceChannel(String name, List<String> participants, int concertId) {
    this.name = name;
    this.participants = participants;
    this.concertId = concertId;
  }

  factory VoiceChannel.fromJson(Map<String, dynamic> json) {
    return VoiceChannel(
      json["name"],
      json["participants"],
      json["concertId"]
    );
  }
}

class GeneralChannel {
  String name;
  int concertId;
  bool voice;
  String imagePath;

  GeneralChannel(String name, int concertId, bool voice, String imagePath) {
    this.name = name;
    this.concertId = concertId;
    this.voice = voice;
    this.imagePath = imagePath;
  }

  factory GeneralChannel.fromJson(Map<String, dynamic> json) {
    return GeneralChannel(
      json["name"],
      json["concertId"],
      json["voice"],
      json["imagePath"]
    );
  }
}

class Message {
  String message;
  User author;

  Message(String message, User author) {
    this.message = message;
    this.author = author;
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        json["message"],
        User.fromJson(json["author"])
    );
  }

  Map<String, dynamic> toJson() => {
    'message': this.message,
    'author': this.author.toJson()
  };

}