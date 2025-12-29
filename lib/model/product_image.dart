class ProductImage {
  final String imageUrl;
  ProductImage({required this.imageUrl});

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(imageUrl: json['image_url']);
  }
}