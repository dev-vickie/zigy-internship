class User {
  final int? id;
  final String email;
  final String firstName;
  final String lastName;
  final String? avatarUrl;

  User({
    this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatarUrl: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatarUrl,
    };
  }
}
