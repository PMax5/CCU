class User {
  String username;
  String email;
  String name;
  String imagePath;
  String type;
  String password;

  User(String username, String email, String name, String imagePath, String type) {
    this.username = username;
    this.email = email;
    this.name = name;
    this.imagePath = imagePath;
    this.type = type;
  }

  User.emptyUser();

  Map<String, dynamic> toJson() => {
    'name': this.name,
    'email': this.email,
    'imagePath': this.imagePath,
    'type': this.type,
    'username': this.username,
    'password': this.password
  };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json["username"],
      json["email"],
      json["name"],
      json["imagePath"],
      json["type"]
    );
  }
}

class Fan extends User {
  Fan(String username, String email, String name, String imagePath) :
        super(username, email, name, imagePath, "FAN");
}

class Artist extends User {
  String description;

  Artist(String username, String email, String name, String imagePath, String description) :
        super(username, email, name, imagePath, "ARTIST") {
    this.description = description;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = super.toJson();
    json['description'] = this.description;
    return json;
  }

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      json["username"],
      json["email"],
      json["name"],
      json["imagePath"],
      json["description"]
    );
  }
}