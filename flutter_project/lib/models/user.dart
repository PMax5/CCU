class User {
  String username;
  String email;
  String name;
  String password;
  String imagePath;
  String type;

  User(String username, String email, String name, String password, String imagePath, String type) {
    this.username = username;
    this.email = email;
    this.name = name;
    this.password = password;
    this.imagePath = imagePath;
    this.type = type;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json["username"],
      json["email"],
      json["name"],
      json["password"],
      json["imagePath"],
      json["type"]
    );
  }
}

class Fan extends User {
  Fan(String username, String email, String name, String password, String imagePath) :
        super(username, email, name, password, imagePath, "FAN");
}

class Artist extends User {
  String description;

  Artist(String username, String email, String name, String password, String imagePath, String description) :
        super(username, email, name, password, imagePath, "ARTIST") {
    this.description = description;
  }

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      json["username"],
      json["email"],
      json["name"],
      json["password"],
      json["imagePath"],
      json["description"]
    );
  }
}