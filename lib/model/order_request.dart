import 'order_item.dart';

class OrderRequest {
  final String shipping;
  final String phone;
  final String payment;
  final List<OrderItem> items; // Renamed to items for consistency
  final double? lat;
  final double? long;

  OrderRequest({
    required this.shipping,
    required this.phone,
    required this.payment,
    required this.items,
    this.lat,
    this.long,
  });

  Map<String, dynamic> toJson() => {
    "shipping_address": shipping,
    "phone_number": phone,
    "payment_method": payment,
    "items": items.map((p) => p.toJson()).toList(),
    "lat": lat,
    "long": long, // Reverted to 'long' as per your previous log
  };
}
