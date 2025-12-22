import 'package:flutter/material.dart';
import 'package:fly/config/app_config.dart';
import 'package:fly/core/widgets/e_button.dart';
import 'package:fly/core/widgets/input_field.dart';
import '../../../config/app_color.dart';

class LoginInput extends StatefulWidget {
  const LoginInput({super.key});

  @override
  State<LoginInput> createState() => _LoginInput();
}

class _LoginInput extends State<LoginInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.grey[500]!.withAlpha((0.26 * 255).round()),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.light, width: 1),
      ),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign In",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                spaceX(5),
                Text(
                  "Forget password",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                spaceX(20),
              ],
            ),
          ),
          InputField(label: "username"),
          spaceX(20),
          InputField(label: "password"),
          spaceX(40),
          EButton(name: "Login", onPressed: () {}),
          spaceX(40),
            Container(
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)
                    
              ),
              child:
             Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               spacing: 20,
              children: [
                Image.asset("${AppConfig.imageUrl}/google.png", height: 25),
                Text("Sign In with google",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            ),
          spaceX(20),
          Container(
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)

            ),
            child:
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                Image.asset("${AppConfig.imageUrl}/facebook.png", height: 25),
                Text("Sign In with google",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget spaceX(double x) {
    return SizedBox(height: x);
  }
}
