class ProductImage {
  final String id;
  final String imageUrl;
  final String? thumbnailUrl;
  final int order;
  final bool isPrimary;
  final String? altText;

  ProductImage({
    required this.id,
    required this.imageUrl,
    this.thumbnailUrl,
    this.order = 0,
    this.isPrimary = false,
    this.altText,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id']?.toString() ?? '0',
      imageUrl: json['image_url'] ?? '',
      thumbnailUrl: json['thumbnail_url'],
      order: json['order'] ?? 0,
      isPrimary: json['is_primary'] == true || json['is_primary'] == 1,
      altText: json['alt_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'thumbnail_url': thumbnailUrl,
      'order': order,
      'is_primary': isPrimary,
      'alt_text': altText,
    };
  }

  // Helper to get the best available image URL
  String get bestImageUrl => thumbnailUrl ?? imageUrl;

  // Copy with method
  ProductImage copyWith({
    String? id,
    String? imageUrl,
    String? thumbnailUrl,
    int? order,
    bool? isPrimary,
    String? altText,
  }) {
    return ProductImage(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      order: order ?? this.order,
      isPrimary: isPrimary ?? this.isPrimary,
      altText: altText ?? this.altText,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductImage && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'ProductImage(id: $id, url: $imageUrl, isPrimary: $isPrimary)';
  }
}