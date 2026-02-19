import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:fly/config/app_config.dart';
import 'package:fly/model/order_item.dart';
import 'package:fly/model/order_request.dart';
import 'package:fly/model/order_response.dard.dart';
import 'package:fly/model/product.dart';
import 'package:http/http.dart' as http;

class OrderService {
  Future<Map<String, dynamic>> createOrder(OrderRequest request, String token) async {
    final requestBody = jsonEncode(request.toJson());
    debugPrint('Create Order Request: $requestBody');
    
    final response = await http.post(
      Uri.parse("${AppConfig.baseUrl}/orders"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
      body: requestBody,
    );

    debugPrint('Create Order status: ${response.statusCode}');
    debugPrint('Create Order body: ${response.body}');

    final body = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception(body["message"] ?? "order failed");
    }
    return body;
  }

  Uint8List decodeQrImage(String qrImage) {
    final base64Str = qrImage.contains(',')
        ? qrImage.split(',').last
        : qrImage;
    return base64Decode(base64Str);
  }

  String buildQrData(Map<String, dynamic> data) {
    final payload = {
      "invoice_no": data["invoice_no"],
      "total_price": data["total_price"],
      "payment_status": data["payment_status"],
    };
    return jsonEncode(payload);
  }
  Future<Map<String, dynamic>> getOrderStatus(String invoiceNo, {required String token}) async {
    final response = await http.get(
      Uri.parse("${AppConfig.baseUrl}/orders/$invoiceNo/status"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200) {
      throw Exception(body["message"] ?? "status check failed");
    }
    return body;
  }

  Future<Map<String, dynamic>> finalizePayment(String invoiceNo, {required String token}) async {
    final response = await http.get(
      Uri.parse("${AppConfig.baseUrl}/qr/pay/$invoiceNo"),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode != 200) {
      throw Exception(body["message"] ?? "payment finalization failed");
    }
    return body;
  }
  Future<OrderResponse> myOrder(String token) async {
    final url = Uri.parse("${AppConfig.baseUrl}/orders");
    final response = await http.get(
      url,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return OrderResponse.fromJson(data);
    } else {
      throw Exception(
        "Failed to load orders: ${response.statusCode} ${response.body}",
      );
    }
  }

}
