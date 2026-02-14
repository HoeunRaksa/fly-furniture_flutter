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
      final rawData = responses['data'] ?? responses; // Fallback to root if data is missing
      if (rawData != null && rawData is Map<String, dynamic> && rawData.containsKey('order')) {
        createdOrder = rawData['order'];
      } else {
        createdOrder = rawData;
      }
    } catch (e) {
      rethrow;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
