class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? profileImage;
  final String? profileImageUrl;
  final bool isVerified;
  final String? token;
  final DateTime? emailVerifiedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.profileImage,
    this.profileImageUrl,
    required this.isVerified,
    this.token,
    this.emailVerifiedAt,
  });

  // For login and verify-otp responses (user + token at root level)
  factory User.fromApiResponse(Map<String, dynamic> json) {
    final userData = json['user'] ?? json;

    return User(
      id: userData['id']?.toString() ?? '',
      name: userData['username'] ?? '',
      email: userData['email'] ?? '',
      role: userData['role'] ?? 'user',
      profileImage: userData['profile_image'],
      profileImageUrl: userData['profile_image_url'],
      isVerified: userData['email_verified_at'] != null,
      token: json['token'], // Token is at root level
      emailVerifiedAt: userData['email_verified_at'] != null
          ? DateTime.parse(userData['email_verified_at'])
          : null,
    );
  }

  // For get-user and update-profile responses (user in 'data' field)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      name: json['username'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'user',
      profileImage: json['profile_image'],
      profileImageUrl: json['profile_image_url'],
      isVerified: json['email_verified_at'] != null,
      token: json['token'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': name,
      'email': email,
      'role': role,
      'profile_image': profileImage,
      'profile_image_url': profileImageUrl,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'token': token,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? profileImage,
    String? profileImageUrl,
    bool? isVerified,
    String? token,
    DateTime? emailVerifiedAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      profileImage: profileImage ?? this.profileImage,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      isVerified: isVerified ?? this.isVerified,
      token: token ?? this.token,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
    );
  }

  String get displayName => name;
  String get avatarUrl => profileImageUrl ?? '';
  bool get hasProfileImage => profileImageUrl != null && profileImageUrl!.isNotEmpty;
}