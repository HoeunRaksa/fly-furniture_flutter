import 'package:flutter/cupertino.dart';
import 'package:fly/features/service/order_service.dart';
import 'package:fly/model/order_request.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService _service = OrderService();
  bool loading = false;
  Map<String, dynamic>? createdOrder;
  Future<void> createOrder(OrderRequest request, String token) async {
    loading = true;
    notifyListeners();
    try {
      final responses = await _service.createOrder(request, token);
      createdOrder = responses['data'];
    } catch (e) {
      rethrow;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
