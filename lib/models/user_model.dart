class User {
  int id = 1;

  String username;
  String email;
  String apiToken;
  User({this.username, this.email, this.apiToken});

  User.map(dynamic obj) {
    this.username = obj["username"];
    this.email = obj["email"];
    this.apiToken = obj["api_token"];
  }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        username: parsedJson['username'],
        apiToken: parsedJson['api_token'],
        email: parsedJson['email']);
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["username"] = username;
    map["email"] = email;
    map["api_token"] = apiToken;

    return map;
  }
}
