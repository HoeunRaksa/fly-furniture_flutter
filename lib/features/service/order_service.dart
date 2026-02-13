import 'dart:convert';
import 'package:fly/config/app_config.dart';
import 'package:fly/model/order_request.dart';
import 'package:http/http.dart' as http;

class OrderService {
    Future<Map<String, dynamic>> createOrder(OrderRequest request, String token) async{
        final response = await http.post(
          Uri.parse("${AppConfig.baseUrl}/orders"),
          headers: {
            "Content-Type" : "application/json",
            "Authorization" : "Bearer $token"
          },
          body: jsonEncode(request.toJson())
        );
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        if(response.statusCode != 201){
          throw Exception(body["message"] ?? "order failed");
        }
        return body;
    }
    String buildQrData(Map<String, dynamic> order){
           final payload ={
               "order_id": order["id"],
               "invoice_no": order["invoice_no"],
               "total_price": order["total_price"],
               "method": order["method"],
           };
           return jsonEncode(payload);
    }
}