class Concert {
  String name;
  String description;
  String date;
  String link;
  String image;
  String username;
  int id;
  int status;
  TextChannel textChannel;
  VoiceChannel voiceChannel;

  Concert(int id, String name, String description, String date, String link, String image, String username, int status) {
    this.name = name;
    this.description = description;
    this.date = date;
    this.link = link;
    this.image = image;
    this.id = id;
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

  VoiceChannel(String name, )

  factory VoiceChannel.fromJson(Map<String, dynamic> json) {
    return
  }
}

class Message {
  String username;
  String message;

  Message(String username, String message) {
    this.username = username;
    this.message = message;
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(json["authorUserName"], json["message"]);
  }
}