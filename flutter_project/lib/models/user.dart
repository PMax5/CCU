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
