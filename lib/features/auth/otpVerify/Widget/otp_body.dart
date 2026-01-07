import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../config/app_color.dart';
import '../../provider/auth_provider.dart';
import 'package:provider/provider.dart';

class OtpBody extends StatefulWidget {
  final String email;
  const OtpBody({super.key, required this.email});

  @override
  State<OtpBody> createState() => _OtpBodyState();
}

class _OtpBodyState extends State<OtpBody> {
  bool isResendEnabled = false;
  int resendTimer = 60;
  bool isLoading = false;
  Timer? _timer;
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void startResendTimer() {
    setState(() {
      isResendEnabled = false;
      resendTimer = 60;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        resendTimer--;
      });

      if (resendTimer <= 0) {
        timer.cancel();
        setState(() {
          isResendEnabled = true;
        });
      }
    });
  }

  Future<void> resendOtp() async {
    if (!isResendEnabled || isLoading) return;

    setState(() => isLoading = true);
    try {
      await context.read<AuthProvider>().resendOtp(widget.email);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP resent successfully")),
        );
        startResendTimer();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to resend OTP: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> verifyOtp(String otp) async {
    if (isLoading || otp.length != 6) return;

    setState(() => isLoading = true);
    try {
      print('Starting OTP verification for: ${widget.email}');
      print('OTP entered: $otp');

      await context.read<AuthProvider>().verifyOtp(widget.email, otp);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("OTP verified successfully!"),
            backgroundColor: Colors.green,
          ),
        );

        // Small delay to show success message
        await Future.delayed(const Duration(milliseconds: 500));

        if (mounted) {
          context.go("/home");
        }
      }
    } catch (e) {
      print('OTP verification error: $e');

      if (mounted) {
        setState(() => isLoading = false);
        _otpController.clear();

        // Extract meaningful error message
        String errorMessage = e.toString();
        if (errorMessage.contains('Exception: ')) {
          errorMessage = errorMessage.replaceAll('Exception: ', '');
        }

        // Show user-friendly message if error is empty or null
        if (errorMessage.isEmpty || errorMessage == 'null') {
          errorMessage = 'Invalid OTP code. Please try again.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),

          // PIN Input
          PinCodeTextField(
            appContext: context,
            length: 6,
            controller: _otpController,
            keyboardType: TextInputType.number,
            autoFocus: true,
            enabled: !isLoading,
            onChanged: (value) {},
            onCompleted: verifyOtp,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(16),
              fieldHeight: 50,
              fieldWidth: 50,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white,
              activeColor: Colors.grey.shade300,
              selectedColor: AppColors.secondaryBlue,
              inactiveColor: Colors.grey.shade200,
            ),
            enableActiveFill: true,
            cursorColor: AppColors.secondaryBlue,
            animationType: AnimationType.fade,
            animationDuration: const Duration(milliseconds: 250),
            backgroundColor: Colors.transparent,
          ),

          const SizedBox(height: 25),

          // Resend OTP Section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't receive code? ",
                style: TextStyle(
                  color: AppColors.mediumGrey,
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: isResendEnabled && !isLoading ? resendOtp : null,
                child: Text(
                  isResendEnabled ? "Resend" : "Resend in ${resendTimer}s",
                  style: TextStyle(
                    color: isResendEnabled
                        ? AppColors.secondaryBlue
                        : Colors.grey.shade400,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    decoration: isResendEnabled
                        ? TextDecoration.underline
                        : TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),

          // Loading Indicator
          if (isLoading) ...[
            const SizedBox(height: 30),
            const CircularProgressIndicator(),
            const SizedBox(height: 10),
            Text(
              "Verifying...",
              style: TextStyle(
                color: AppColors.mediumGrey,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }
}