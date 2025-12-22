import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'login_input_box.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LoginInput()
          ],
        ),
      ),
    );
  }
}
