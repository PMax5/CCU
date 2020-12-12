class User {
  String username;
  String email;
  String name;
  String imagePath;
  String type;
  String password;
  String description;
  List<dynamic> favorites;

  User(String username, String email, String name, String imagePath, String type, String description, List<dynamic> favorites) {
    this.username = username;
    this.email = email;
    this.name = name;
    this.imagePath = imagePath;
    this.type = type;
    this.description = description;
    this.favorites = favorites;
  }


  Map<String, dynamic> toJson() => {
    'name': this.name,
    'email': this.email,
    'imagePath': this.imagePath,
    'type': this.type,
    'username': this.username,
    'password': this.password,
    'description': this.description
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json["username"],
      json["email"],
      json["name"],
      json["imagePath"],
      json["type"],
      json["description"],
      json["favorites"]
    );
  }
}

class TextChannel {
  String name;
  List<Message> messages;
  int concertId;
  TextChannel(String name, int concertId) {
    this.name = name;
    this.concertId = concertId;
  }

  void loadTextMessages(List<Message> messages) {
    this.messages = messages;
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

class VoiceChannel {
  String name;
  List<String> participants;
  int status;
  int concertId
  VoiceChannel(String name, List<String> participants, int status, int concertId) {
    this.name = name;
    this.participants = participants;
    this.status = status;
    this.concertId = concertId;
  }

  factory VoiceChannel.fromJson(Map<String, dynamic> json) {
    return VoiceChannel(
      json["name"],
      json["participants"],
      json["status"],
      json["concertId"]
    );
  }
}

