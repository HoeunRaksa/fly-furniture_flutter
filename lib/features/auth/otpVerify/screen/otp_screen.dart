import 'package:flutter/material.dart';
import 'package:fly/features/auth/otpVerify/Widget/otp_header.dart';
import '../Widget/otp_body.dart';

class OtpVerification extends StatelessWidget {
  final String email;
  const OtpVerification({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          OtpHeader(email: email),
          Expanded(
            child: OtpBody(email: email),
          ),
        ],
      ),
    );
  }
}