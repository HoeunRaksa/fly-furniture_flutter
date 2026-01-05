class User {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final String role;
  final bool isVerified;
  String? token; // Make it nullable, and set later from API root

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImage,
    required this.role,
    required this.isVerified,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'],
      email: json['email'],
      profileImage: json['profile_image'],
      role: json['role'],
      isVerified: json['email_verified_at'] != null,
      token: json['token'], // This will be null if not included here
    );
  }

  // Helper to merge the root token into the user
  static User fromApiResponse(Map<String, dynamic> json) {
    final user = User.fromJson(json['user']);
    user.token = json['token']; // Set token from root
    return user;
  }
}
