import 'package:fly/model/order_item.dart';
class OrderRequest {
      final String shipping;
      final String phone;
      final String payment;
      final List<OrderItem> item;
      OrderRequest({required this.shipping, required this.phone, required this.payment, required this.item});
      Map<String, dynamic> toJson () => {
            "shipping_address" : shipping,
            "phone_number" : phone,
            "payment_method": payment,
             "items" : item.map((p) => p.toJson()).toList()
      };
}