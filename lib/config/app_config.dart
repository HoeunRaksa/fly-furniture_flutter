class AppConfig {
  static const String imageUrl = "assets/images";
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  static const String storageUrl = 'http://10.0.2.2:8000/storage';
  static String getImageUrl(String path) => '$storageUrl/$path';
}