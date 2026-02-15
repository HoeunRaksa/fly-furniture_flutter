import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fly/features/service/order_service.dart';
import 'package:fly/providers/cardProvider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fly/features/auth/provider/auth_provider.dart';

class QrImageScreen extends StatefulWidget {
  final String qrImage; // "data:image/png;base64,..."
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
      // Optionally show error in a snackbar if it's a real issue
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

    final bytes = base64Decode(widget.qrImage.split(',').last);

    return Scaffold(
      appBar: AppBar(title: const Text("Pay by QR")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.memory(bytes, width: 260),
            const SizedBox(height: 12),
            Text("Invoice: ${widget.invoiceNo}"),
            const SizedBox(height: 24),
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
          ],
        ),
      ),
    );
  }
}
