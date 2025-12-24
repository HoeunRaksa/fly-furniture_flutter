import 'package:flutter/material.dart';
import 'package:fly/config/app_config.dart';
import 'package:fly/core/widgets/e_button.dart';
import 'package:fly/core/widgets/input_field.dart';
import 'package:fly/features/auth/provider/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../config/app_color.dart';
import '../../../../core/widgets/check_box.dart';

class RegisterInput extends StatefulWidget {
  const RegisterInput({super.key});
  @override
  State<RegisterInput> createState() => _RegisterInput();
}

class _RegisterInput extends State<RegisterInput> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController =TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, right: 1, left: 1),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Firstname", style: Theme.of(context).textTheme.bodyLarge),
          spaceX(9),
          InputField(label: "firstname", controller: firstNameController),
          spaceX(20),
          Text("Lastname", style: Theme.of(context).textTheme.bodyLarge),
          spaceX(9),
          InputField(label: "lastname", controller: lastNameController),
          spaceX(20),
          Text("Email", style: Theme.of(context).textTheme.bodyLarge),
          spaceX(9),
          InputField(label: "username", controller: emailController),
          spaceX(20),
          Text("Password", style: Theme.of(context).textTheme.bodyLarge),
          spaceX(9),
          InputField(label: "password", controller: passwordController),
          spaceX(15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CheckBoxed(
                value: isChecked,
                valueChanged: (bool? newValue) {
                  setState(() {
                    isChecked = newValue ?? false;
                  });
                },
                label: "Remember For 30 Days",
              ),
              Text(
                "Forget password",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          spaceX(20),
          Center(
            child: EButton(
              name: "Register",
              onPressed: () async {
                // final authProvider = context.read<AuthProvider>();
                // var name =  "${firstNameController.text.trim()} ${lastNameController.text.trim()}";
                // try {
                //   await authProvider.register(
                //     name,
                //     emailController.text.trim(),
                //     passwordController.text.trim(),
                //   );
                // } catch (e) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text(e.toString().replaceAll('Exception: ', '')),
                //       backgroundColor: Colors.red,
                //     ),
                //   );
                // }
                context.push('/verifyEmail');
              },
            ),
          ),
          spaceX(20),
        ],
      ),
    );
  }
  Widget spaceX(double x) {
    return SizedBox(height: x);
  }
}
