import 'package:flutter/material.dart';
import 'package:fly/core/widgets/input_field.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/check_box.dart';
import '../../provider/auth_provider.dart';

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
  bool isLoading = false;

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
              maxWidth: 420,
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
                      label: "firstname", controller: firstNameController),
                  spaceX(20),
                  Text("Lastname",
                      style: Theme.of(context).textTheme.bodyLarge),
                  spaceX(9),
                  InputField(
                      label: "lastname", controller: lastNameController),
                  spaceX(20),
                  Text("Email", style: Theme.of(context).textTheme.bodyLarge),
                  spaceX(9),
                  InputField(label: "username", controller: emailController),
                  spaceX(20),
                  Text("Password",
                      style: Theme.of(context).textTheme.bodyLarge),
                  spaceX(9),
                  InputField(
                      label: "password", controller: passwordController),
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
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  spaceX(20),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : () async {
                          final firstName = firstNameController.text.trim();
                          final lastName = lastNameController.text.trim();
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();

                          if (email.isEmpty ||
                              password.isEmpty ||
                              firstName.isEmpty ||
                              lastName.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please fill all fields")),
                            );
                            return;
                          }

                          setState(() {
                            isLoading = true;
                          });

                          try {
                            await context.read<AuthProvider>().register(
                              '$firstName $lastName',
                              email,
                              password,
                            );

                            debugPrint("Register success, navigating to OTP with email: $email");

                            if (mounted) {
                              // Hide keyboard before navigation
                              FocusScope.of(context).unfocus();

                              // Small delay to ensure keyboard is hidden
                              await Future.delayed(const Duration(milliseconds: 100));

                              // Navigate to OTP screen with email
                              context.push(
                                AppRoutes.verifyEmail,
                                extra: {'email': email},
                              );
                            }
                          } catch (e) {
                            if (mounted) {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          }
                        },
                        child: isLoading
                            ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        )
                            : const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget spaceX(double x) => SizedBox(height: x);
}