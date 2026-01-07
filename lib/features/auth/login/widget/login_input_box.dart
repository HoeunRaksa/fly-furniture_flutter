import 'package:flutter/material.dart';
import 'package:fly/core/widgets/elevated_button.dart';
import 'package:fly/core/widgets/input_field.dart';
import 'package:fly/features/auth/provider/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../config/app_color.dart';
import '../../../../core/widgets/check_box.dart';

class LoginInput extends StatefulWidget {
  const LoginInput({super.key});

  @override
  State<LoginInput> createState() => _LoginInput();
}

class _LoginInput extends State<LoginInput> {
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
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email", style: Theme.of(context).textTheme.bodySmall),
                    spaceX(9),
                    InputField(label: "username", controller: emailController),
                    spaceX(20),

                    Text(
                      "Password",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    spaceX(9),
                    InputField(
                      label: "password",
                      controller: passwordController,
                    ),
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
                      child: EleButton(
                        name: "Login",
                        isLoading: isLoading,
                        onPressed: () async {
                        if(isLoading) return;
                          setState(() => isLoading = true
                          );
                          final authProvider = context.read<AuthProvider>();
                          final messenger = ScaffoldMessenger.of(context);

                          try {
                            await authProvider.login(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );

                            if (!mounted) return; // ✅ prevent context usage after async
                          } catch (e) {
                            if (!mounted) return; // ✅ safe guard

                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(
                                  e.toString().replaceAll('Exception: ', ''),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      ),
                    ),

                    spaceX(20),

                    Row(
                      children: [
                        const Expanded(child: Divider(thickness: 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "or",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        const Expanded(child: Divider(thickness: 1)),
                      ],
                    ),

                    spaceX(20),

                    Center(
                      child: Container(
                        height: 40,
                        width: 230,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: AppColors.mediumGrey.withAlpha(100),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            context.push('/register');
                          },
                          child: Text(
                            "Create Account",
                            style: TextStyle(color: AppColors.mediumGrey),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget spaceX(double x) => SizedBox(height: x);
}
