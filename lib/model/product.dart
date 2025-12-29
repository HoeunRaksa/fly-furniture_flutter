import 'package:fly/model/product_image.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final List<ProductImage> images;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var list = json['images'] as List;
    List<ProductImage> imagesList =
    list.map((i) => ProductImage.fromJson(i)).toList();

    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      images: imagesList,
    );
  }
}