import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly/features/auth/register/widget/register_input.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RegisterInput()
          ],
        ),
      ),
    );
  }
}
