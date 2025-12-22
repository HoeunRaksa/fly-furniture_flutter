import 'package:flutter/material.dart';
import '../widget/background_login.dart';
import '../widget/login_body.dart';
import '../widget/login_header.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: LoginHeader(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              BackgroundLogin(),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, right: 30, left: 30),
                  child: const LoginBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
