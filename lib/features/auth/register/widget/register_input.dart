import 'package:flutter/material.dart';
import 'package:fly/core/widgets/elevated_button.dart';
import 'package:fly/core/widgets/input_field.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/check_box.dart';
class RegisterInput extends StatefulWidget {
  const RegisterInput({super.key});

  @override
  State<RegisterInput> createState() => _RegisterInput();
}
class _RegisterInput extends State<RegisterInput> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 420, // ⭐ ideal form width
            ),
            child: Container(
              padding: const EdgeInsets.only(top: 15, left: 1, right: 1),
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(15)),
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Firstname",
                      style: Theme.of(context).textTheme.bodyLarge),
                  spaceX(9),
                  InputField(
                      label: "firstname",
                      controller: firstNameController),
                  spaceX(20),
                  Text("Lastname",
                      style: Theme.of(context).textTheme.bodyLarge),
                  spaceX(9),
                  InputField(
                      label: "lastname",
                      controller: lastNameController),
                  spaceX(20),
                  Text("Email",
                      style: Theme.of(context).textTheme.bodyLarge),
                  spaceX(9),
                  InputField(
                      label: "username",
                      controller: emailController),
                  spaceX(20),
                  Text("Password",
                      style: Theme.of(context).textTheme.bodyLarge),
                  spaceX(9),
                  InputField(
                      label: "password",
                      controller: passwordController),
                  spaceX(15),
                  Row(
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
                        style:
                        Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  spaceX(20),
                  Center(
                    child: EButton(
                      name: "Register",
                      onPressed: () async {
                        context.push('/verifyEmail');
                      },
                    ),
                  ),
                  spaceX(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget spaceX(double x) => SizedBox(height: x);
}
