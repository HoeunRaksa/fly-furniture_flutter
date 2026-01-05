class User {
  final String id;
  final String name;
  final String email;
  final String? profileImage;
  final String role;
  final bool isVerified;
  String? token; // Mutable to set from API root level

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
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profile_image'],
      role: json['role'] ?? 'user',
      isVerified: json['email_verified_at'] != null,
      token: json['token'],
    );
  }

  // Handle API response where token is at root level and user is nested
  static User fromApiResponse(Map<String, dynamic> json) {
    // Check if the structure has both 'token' at root and 'user' nested
    if (json.containsKey('token') && json.containsKey('user')) {
      final user = User.fromJson(json['user']);
      user.token = json['token']; // Set token from root level
      return user;
    }

    // Otherwise, parse directly (for login response, etc.)
    return User.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profile_image': profileImage,
      'role': role,
      'is_verified': isVerified,
      'token': token,
    };
  }
}