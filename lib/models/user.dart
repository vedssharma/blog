class User {
  const User(
      {required this.email, required this.username, required this.password});
  final String email;
  final String username;
  final String password;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> user = <String, dynamic>{};
    user["email"] = email;
    user["username"] = username;
    user["password"] = password;
    return user;
  }

  User.fromJson(Map<String, dynamic> json)
      : password = json['password'],
        email = json['email'],
        username = json["username"];
}
