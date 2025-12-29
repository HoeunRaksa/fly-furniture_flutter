class User {
  final String id;
  final String name;
  final String email;
  final String token;
  final bool isVerified;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
    required this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'],
      email: json['email'],
      token: json['token'] ?? '',
      isVerified: json['email_verified_at'] != null,
    );
  }
}
