import 'package:flutter/cupertino.dart';
import 'package:fly/features/service/order_service.dart';
import 'package:fly/model/order_request.dart';
import 'package:fly/model/order_response.dard.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService _service = OrderService();
  bool loading = false;
  Map<String, dynamic>? createdOrder;
  // ✅ store orders result
  OrderResponse? _orderResponse;

  // ✅ expose nullable
  OrderResponse? get orderResponse => _orderResponse;
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
  Future<void> myOrder(String token) async{
     loading = true;
     notifyListeners();
     try{
      final response =  await _service.myOrder(token);
      _orderResponse = response;
     }catch(ex){
       throw Exception("Empty data state: $ex");
     }finally {
       loading = false;
       notifyListeners();
     }
  }
}
