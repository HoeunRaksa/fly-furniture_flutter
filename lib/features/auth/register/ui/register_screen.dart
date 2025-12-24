import 'package:flutter/material.dart';
import 'package:fly/features/auth/register/widget/register_header.dart';

import '../widget/register_body.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: RegisterHeader(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(top: 0, right: 20, left: 20),
                  child: const RegisterBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
