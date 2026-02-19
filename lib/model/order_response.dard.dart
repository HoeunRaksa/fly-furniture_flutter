import 'order_model.dart';

class OrderResponse {
  final List<Order> orders;

  OrderResponse({required this.orders});

  factory OrderResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return OrderResponse(orders: []);
    final list = json["data"] as List? ?? [];

    return OrderResponse(
      orders: list
          .map((p) => Order.fromJson(p as Map<String, dynamic>))
          .toList(),
    );
  }
}
