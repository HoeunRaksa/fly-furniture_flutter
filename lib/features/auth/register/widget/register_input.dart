import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly/core/widgets/input_field.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/check_box.dart';
import '../../../../config/app_color.dart';
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
    //final brightness = MediaQuery.of(context).platformBrightness;
   // final isDark = brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Firstname",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
            color: CupertinoColors.label.resolveFrom(context),
          ),
        ),
        spaceX(9),
        InputField(label: "firstname", controller: firstNameController),
        spaceX(20),
        Text(
          "Lastname",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
            color: CupertinoColors.label.resolveFrom(context),
          ),
        ),
        spaceX(9),
        InputField(label: "lastname", controller: lastNameController),
        spaceX(20),
        Text(
          "Email",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
            color: CupertinoColors.label.resolveFrom(context),
          ),
        ),
        spaceX(9),
        InputField(label: "username", controller: emailController),
        spaceX(20),
        Text(
          "Password",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
            color: CupertinoColors.label.resolveFrom(context),
          ),
        ),
        spaceX(9),
        InputField(label: "password", controller: passwordController, obscureText: true),
        spaceX(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CheckBoxed(
                value: isChecked,
                valueChanged: (bool? newValue) {
                  setState(() {
                    isChecked = newValue ?? false;
                  });
                },
                label: "Remember For 30 Days",
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                // Handle forgot password
              },
              child: Text(
                "Forget password",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1,
                  color: AppColors.secondaryGreen,
                ),
              ),
            ),
          ],
        ),
        spaceX(24),
        Center(
          child: Container(
            width: double.infinity,
            height: 54,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.secondaryGreen,
                  AppColors.secondaryGreen.withValues(alpha: 0.85),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondaryGreen.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: AppColors.secondaryGreen.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () async {
                final messenger = ScaffoldMessenger.of(context); // ✅ capture early
                final router = GoRouter.of(context); // ✅ capture early

                final firstName = firstNameController.text.trim();
                final lastName = lastNameController.text.trim();
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                if (email.isEmpty ||
                    password.isEmpty ||
                    firstName.isEmpty ||
                    lastName.isEmpty) {
                  messenger.showSnackBar(
                    const SnackBar(content: Text("Please fill all fields")),
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

                  if (!mounted) return; // ✅ safe guard

                  FocusScope.of(context).unfocus();
                  await Future.delayed(const Duration(milliseconds: 100));

                  if (!mounted) return; // ✅ safe guard again
                  router.push(
                    AppRoutes.verifyEmail,
                    extra: {'email': email},
                  );
                } catch (e) {
                  if (!mounted) return;

                  setState(() {
                    isLoading = false;
                  });

                  messenger.showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.zero,
              ),
              child: isLoading
                  ? const SizedBox(
                width: 22,
                height: 22,
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 11,
                ),
              )
                  : const Text(
                "Register",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        spaceX(20),
      ],
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