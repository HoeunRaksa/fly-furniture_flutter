import 'order_item.dart';

class Order {
  final String shipping;
  final String phone;
  final String payment;
  final List<OrderItem> items;
  final double? lat;
  final double? long;

  Order({
    required this.shipping,
    required this.phone,
    required this.payment,
    required this.items,
    this.lat,
    this.long,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    final jsonItems = json["items"] as List? ?? [];

    return Order(
      shipping: (json["shipping_address"] ?? '').toString(), // ✅ safe
      phone: (json["phone_number"] ?? '').toString(),        // ✅ safe
      payment: (json["method"] ?? '').toString(),            // ✅ safe
      items: jsonItems
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      lat: _toDouble(json["lat"]),
      long: _toDouble(json["long"]),
    );
  }
}

double? _toDouble(dynamic v) {
  if (v == null) return null;
  if (v is double) return v;
  if (v is int) return v.toDouble();
  return double.tryParse(v.toString());
}
