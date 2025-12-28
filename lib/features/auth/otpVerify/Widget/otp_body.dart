import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../config/app_color.dart';

class OtpBody extends StatefulWidget {
  const OtpBody({super.key});

  @override
  State<OtpBody> createState() => _OtpBodyState();
}

class _OtpBodyState extends State<OtpBody> {
  bool isResendEnabled = true;
  int resendTimer = 30;

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  void startResendTimer() {
    isResendEnabled = false;
    resendTimer = 30;
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (resendTimer > 0) {
        setState(() => resendTimer--);
        return true;
      } else {
        setState(() => isResendEnabled = true);
        return false;
      }
    });
  }

  void resendOtp() {
    print("Resend OTP clicked");
    startResendTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // iOS-style PIN fields
            PinCodeTextField(
              appContext: context,
              length: 6,
              keyboardType: TextInputType.number,
              autoFocus: true,
              onChanged: (value) {},
              onCompleted: (value) => context.push("/home"),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't receive code? ",
                  style: TextStyle(color: AppColors.gray700, fontSize: 14),
                ),
                GestureDetector(
                  onTap: isResendEnabled ? resendOtp : null,
                  child: Text(
                    isResendEnabled ? "Resend" : "Resend in $resendTimer s",
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
          ],
        ),
      ),
    );
  }
}
