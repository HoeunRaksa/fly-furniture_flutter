import 'dart:async';

import 'package:flutter/material.dart'; // REQUIRED for ScaffoldMessenger
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart'; // REQUIRED for context.read
import 'package:go_router/go_router.dart'; // REQUIRED for context.go
import 'package:fly/features/auth/provider/auth_provider.dart'; // REQUIRED for AuthProvider

import '../../features/service/order_service.dart';

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

    // Use locally generated QR code with raw Invoice Number
    // This allows the custom Bank App to scan it and recognize the ID directly
    return Scaffold(
      appBar: AppBar(title: const Text("Pay by QR")),
      body: Center(
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
                // Use the full URL so the Bank App recognizes it as a valid link
                data: "https://bank.furniture.learner-teach.online/pay/${widget.invoiceNo}",
                version: QrVersions.auto,
                size: 260.0,
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
                const Text("Waiting for payment callback...", style: TextStyle(color: Colors.grey)),
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
    );
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to trigger payment: $e")),
      );
    }
  }
}
