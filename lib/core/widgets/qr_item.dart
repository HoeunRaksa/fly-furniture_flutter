import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fly/features/service/order_service.dart';
import 'package:fly/providers/cardProvider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fly/features/auth/provider/auth_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrImageScreen extends StatefulWidget {
  final String qrImage; // "data:image/png;base64,..." (Ignored now)
  final String invoiceNo; // from backend
  const QrImageScreen({
    super.key,
    required this.qrImage,
    required this.invoiceNo,
  });

  @override
  State<QrImageScreen> createState() => _QrImageScreenState();
}

class _QrImageScreenState extends State<QrImageScreen> {
  final _service = OrderService();
  Timer? _timer;
  bool _checking = false;
  bool _isPaid = false;
  
  // Custom QR Data for debugging
  String _customQrData = "";

  void _updateQr(String newData) {
      setState(() {
          _customQrData = newData;
      });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) => _poll());
  }

  Future<void> _poll() async {
    if (_checking || _isPaid) return;
    _checking = true;

    try {
      final token = context.read<AuthProvider>().token;
      if (token == null) return;

      final res = await _service.getOrderStatus(widget.invoiceNo, token: token);
      debugPrint("Polling status for ${widget.invoiceNo}: $res");

      final data = res["data"] as Map<String, dynamic>?;
      final paymentStatus = data?["payment_status"]?.toString().toLowerCase();

      if (!mounted) return;

      if (paymentStatus == "paid") {
        debugPrint("Payment detected as PAID!");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Payment Successful!")),
        );
        setState(() {
          _isPaid = true;
        });
        _timer?.cancel();

        // ✅ Clear cart on success
        await context.read<CardProvider>().clear();
      }
    } catch (e) {
      debugPrint("Polling error: $e");
    } finally {
      if (mounted) {
        setState(() {
          _checking = false;
        });
      }
    }
  }

  Future<void> _simulatePayment() async {
    try {
      final token = context.read<AuthProvider>().token;
      if (token == null) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Simulating payment scan...")),
      );

      // This calls the endpoint that marks the order as 'paid'
      await _service.finalizePayment(widget.invoiceNo, token: token);
      
      // The polling timer will pick up the change in the next 3 seconds
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to trigger payment: $e")),
        );
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isPaid) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: 24),
              const Text(
                "Payment Successful!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text("Invoice: ${widget.invoiceNo}"),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => context.go('/home'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Back to Home", style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      );
    }

    // Use custom data if edited, otherwise fallback to defaults
    String qrData = _customQrData.isNotEmpty ? _customQrData : "https://bank.furniture.learner-teach.online/pay/${widget.invoiceNo}";

    return Scaffold(
      appBar: AppBar(title: const Text("Pay by QR")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 5,
                    )
                  ],
                ),
                child: QrImageView(
                  data: qrData,
                  version: QrVersions.auto,
                  size: 260.0,
                ),
              ),
              const SizedBox(height: 24),
              // Debug Controls Restored for troubleshooting
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: TextField(
                      decoration: const InputDecoration(
                          labelText: "QR Content Debugger",
                          border: OutlineInputBorder(),
                          isDense: true,
                      ),
                      onChanged: _updateQr,
                      controller: TextEditingController(text: qrData),
                  ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      _buildChip("Link", "https://bank.furniture.learner-teach.online/pay/${widget.invoiceNo}"),
                      const SizedBox(width: 8),
                      _buildChip("ID Only", widget.invoiceNo),
                      const SizedBox(width: 8),
                      _buildChip("JSON (Basic)", '{"invoice_no":"${widget.invoiceNo}"}'),
                      const SizedBox(width: 8),
                      // Try including Amount/Currency based on user's hint about "pay" logic
                      _buildChip("JSON (Full)", '{"invoice_no":"${widget.invoiceNo}","amount":0.00,"currency":"USD"}'), 
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              Text(
                "Invoice: ${widget.invoiceNo}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 12),
                  const Text("Waiting for payment...", style: TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 40),
              TextButton.icon(
                onPressed: _simulatePayment,
                icon: const Icon(Icons.bolt, color: Colors.orange),
                label: const Text("Simulate Scan & Pay (Testing)", style: TextStyle(color: Colors.orange)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label, String data) {
      return ActionChip(
          label: Text(label),
          onPressed: () => _updateQr(data),
          backgroundColor: _customQrData == data ? Colors.blue[100] : null,
      );
  }
