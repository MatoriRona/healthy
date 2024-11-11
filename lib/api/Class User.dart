class User {
  final int id;
  final String username;
  final String email;
  final String fullname;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.fullname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      fullname: json['fullname'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'fullname': fullname,
    };
  }
}
