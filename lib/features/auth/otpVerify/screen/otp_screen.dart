import 'package:flutter/material.dart';
import 'package:fly/features/auth/otpVerify/Widget/otp_header.dart';

import '../Widget/otp_body.dart';

class OtpVerification extends StatelessWidget{
     const OtpVerification({super.key});
     @override
     Widget build(BuildContext context) {
       return Scaffold(
         backgroundColor: Theme.of(context).scaffoldBackgroundColor, // iOS-style clean background
         body: Column(
           children: const [
             OtpHeader(),
             Expanded(
               child: OtpBody(),
             ),
           ],
         ),
       );
     }
}