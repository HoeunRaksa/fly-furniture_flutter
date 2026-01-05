import 'package:fly/model/product_image.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final double discount;
  final int stock;
  final double rating;
  final List<ProductImage> images;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.stock,
    required this.rating,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var list = json['images'] as List? ?? [];
    List<ProductImage> imagesList =
    list.map((i) => ProductImage.fromJson(i)).toList();

    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: _parseDouble(json['price']),
      discount: _parseDouble(json['discount']),
      stock: _parseInt(json['stock']),
      rating: _parseDouble(json['rating']),
      images: imagesList,
    );
  }

  // Safe parsing methods
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'stock': stock,
      'rating': rating,
      'images': images.map((img) => img.toJson()).toList(),
    };
  }

  // Helper method to get discounted price
  double get discountedPrice {
    if (discount > 0) {
      return price - (price * discount / 100);
    }
    return price;
  }

  // Helper method to check if product is in stock
  bool get isInStock => stock > 0;

  // Helper method to check if product has discount
  bool get hasDiscount => discount > 0;
}