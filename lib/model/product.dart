import 'package:fly/model/product_image.dart';

import 'product_category.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double discount;
  final int stock;
  final ProductCategory? category;
  final List<ProductImage> images;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int reviewCount;
  final bool isFeatured;
  final bool isActive;
  final bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.stock,
    this.category,
    required this.images,
    required this.createdAt,
    required this.updatedAt,
    this.reviewCount = 0,
    this.isFeatured = false,
    this.isActive = true,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var list = json['images'] as List? ?? [];
    List<ProductImage> imagesList =
        list.map((i) => ProductImage.fromJson(i)).toList();

    return Product(
      id: json['id']?.toString() ?? '0',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: _parseDouble(json['price']),
      discount: _parseDouble(json['discount']),
      stock: _parseInt(json['stock']),
      category: json['category'] != null && json['category'] is Map<String, dynamic>
          ? ProductCategory.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      images: imagesList,
      createdAt: _parseDateTime(json['created_at']),
      updatedAt: _parseDateTime(json['updated_at']),
      reviewCount: _parseInt(json['review_count']),
      isFeatured: json['is_featured'] == true || json['is_featured'] == 1,
      isActive: json['is_active'] == true || json['is_active'] == 1,
      isFavorite: json['is_favorite'] ?? false,
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

  static DateTime _parseDateTime(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (_) {
        return DateTime.now();
      }
    }
    return DateTime.now();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'discount': discount,
      'stock': stock,
      'category': category,
      'images': images.map((img) => img.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'review_count': reviewCount,
      'is_featured': isFeatured,
      'is_active': isActive,
    };
  }

  // Helper method to get discounted price
  double get discountedPrice {
    if (discount > 0) {
      return price - (price * discount / 100);
    }
    return price;
  }

  // Helper method to get discount amount in currency
  double get discountAmount {
    if (discount > 0) {
      return price * discount / 100;
    }
    return 0.0;
  }

  // Helper method to check if product is in stock
  bool get isInStock => stock > 0;

  // Helper method to check if product has discount
  bool get hasDiscount => discount > 0;

  // Helper method to check if product has images
  bool get hasImages => images.isNotEmpty;

  // Helper method to get main image URL
  String? get mainImageUrl => images.isNotEmpty ? images.first.imageUrl : null;

  // Helper method to get stock status text
  String get stockStatus {
    if (stock <= 0) return 'Out of Stock';
    if (stock <= 5) return 'Low Stock ($stock left)';
    return 'In Stock';
  }

  // Helper method to get stock status color indicator
  StockStatusColor get stockStatusColor {
    if (stock <= 0) return StockStatusColor.outOfStock;
    if (stock <= 5) return StockStatusColor.lowStock;
    return StockStatusColor.inStock;
  }

  // Helper method to get rating stars (0-5)

  // Helper method to format price
  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
  String get formattedDiscountedPrice => '\$${discountedPrice.toStringAsFixed(2)}';

  // Helper method to check if product is new (created within last 7 days)
  bool get isNew {
    final difference = DateTime.now().difference(createdAt);
    return difference.inDays <= 7;
  }

  // Helper method to check if product is on sale
  bool get isOnSale => hasDiscount && isActive;

  // Helper method to calculate savings percentage
  String get savingsText {
    if (hasDiscount) {
      return 'Save ${discount.toStringAsFixed(0)}%';
    }
    return '';
  }

  // Helper method to get availability text
  String get availabilityText {
    if (!isActive) return 'Unavailable';
    if (!isInStock) return 'Out of Stock';
    if (stock <= 5) return 'Only $stock left';
    return 'Available';
  }

  // Copy with method for creating modified copies
  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? discount,
    int? stock,
    ProductCategory? category,
    List<ProductImage>? images,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? reviewCount,
    bool? isFeatured,
    bool? isActive,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      stock: stock ?? this.stock,
      category: category ?? this.category,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reviewCount: reviewCount ?? this.reviewCount,
      isFeatured: isFeatured ?? this.isFeatured,
      isActive: isActive ?? this.isActive,
      isFavorite: isFavorite ?? this.isFavorite, // ✅ ADD
    );
  }



  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Product(id: $id, name: $name, price: $price, stock: $stock)';
  }
}

// Enum for stock status colors
enum StockStatusColor {
  inStock,
  lowStock,
  outOfStock,
}