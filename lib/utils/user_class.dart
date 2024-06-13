class User {
  final String email;
  final String password;
  final String name;
  final String id;

  User({
    required this.email,
    required this.password,
    required this.name,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'id': id,
    };
  }
}
