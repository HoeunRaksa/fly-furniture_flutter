import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrItem extends StatelessWidget {
  final String qrData;
  const QrItem({super.key, required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pay by QR")),
      body: Center(child: QrImageView(data: qrData, size: 260)),
    );
  }
}
