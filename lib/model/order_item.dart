import 'product.dart';

class OrderItem {
  final int productId;
  final int quantity;
  final double? price;
  final Product? product;

  OrderItem({
    required this.productId,
    required this.quantity,
    this.price,
    this.product,
  });

  /// POST request
  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "quantity": quantity,
  };

  /// GET response
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: _parseInt(json["product_id"]),
      quantity: _parseInt(json["quantity"]),
      price: _toDouble(json["price"]),
      product: json["product"] != null
          ? Product.fromJson(json["product"])
          : null,
    );
  }
}

int _parseInt(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is String) return int.tryParse(v) ?? 0;
  return 0;
}

double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  return double.tryParse(value.toString());
}
