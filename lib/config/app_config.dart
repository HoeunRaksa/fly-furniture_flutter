class AppConfig {
  static const String imageUrl = "assets/images";
  static const String baseUrl = 'https://api.furniture.learner-teach.online/api';
  static const String storageUrl = 'https://api.furniture.learner-teach.online';
  static String getImageUrl(String path) => '$storageUrl/$path';
}