class User{
  final int id;
  final String name;
  final String email;
  final String password;


  User({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.password = '',
  });


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}