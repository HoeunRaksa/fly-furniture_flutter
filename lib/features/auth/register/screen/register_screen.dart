import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../config/app_color.dart';
import '../../../../config/app_config.dart';
import '../../../../core/routing/app_routes.dart';
import '../../login/screen/login_screen.dart';
import '../../provider/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  final _passwordVisible = ValueNotifier<bool>(false);

  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _passwordVisible.dispose();
    super.dispose();
  }

  // =====================================================
  // REGISTER (same behavior as RegisterInput)
  // =====================================================
  Future<void> _onRegister() async {
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await context.read<AuthProvider>().register(
        '${_firstNameCtrl.text.trim()} ${_lastNameCtrl.text.trim()}',
        _emailCtrl.text.trim(),
        _passwordCtrl.text.trim(),
      );

      if (!mounted) return;

      FocusScope.of(context).unfocus();
      await Future.delayed(const Duration(milliseconds: 100));

      if (!mounted) return;

      router.push(
        AppRoutes.verifyEmail,
        extra: {'email': _emailCtrl.text.trim()},
      );
    } catch (e) {
      if (!mounted) return;

      messenger.showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Register",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.8,
            color: AppColors.woodWalnut,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(AppRoutes.welcome);
            }
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEFFAF3),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    "Create your account to get started",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  Image.asset("${AppConfig.imageUrl}/welcomestore.png"),

                  const SizedBox(height: 20),

                  // ---------------- First Name ----------------
                  AuthTextField(
                    controller: _firstNameCtrl,
                    label: "First Name",
                    hint: "John",
                    validator: (v) =>
                    v!.isEmpty ? "First name required" : null,
                  ),

                  const SizedBox(height: 16),

                  // ---------------- Last Name ----------------
                  AuthTextField(
                    controller: _lastNameCtrl,
                    label: "Last Name",
                    hint: "Doe",
                    validator: (v) =>
                    v!.isEmpty ? "Last name required" : null,
                  ),

                  const SizedBox(height: 16),

                  // ---------------- Email ----------------
                  AuthTextField(
                    controller: _emailCtrl,
                    label: "Email",
                    hint: "you@example.com",
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    validator: (v) {
                      if (v!.isEmpty) return "Email required";
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                        return "Invalid email";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // ---------------- Password ----------------
                  ValueListenableBuilder<bool>(
                    valueListenable: _passwordVisible,
                    builder: (_, visible, __) {
                      return AuthTextField(
                        controller: _passwordCtrl,
                        label: "Password",
                        hint: "Minimum 6 characters",
                        obscureText: !visible,
                        prefixIcon: Icons.lock_outline,
                        suffix: IconButton(
                          icon: Icon(
                            visible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () =>
                          _passwordVisible.value = !visible,
                        ),
                        validator: (v) =>
                        v!.length < 6 ? "Min 6 characters" : null,
                      );
                    },
                  ),

                  const SizedBox(height: 10),

                  // ---------------- Remember Me ----------------
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (v) =>
                            setState(() => _rememberMe = v ?? false),
                      ),
                      const Text("Remember me"),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // ---------------- Register Button ----------------
                  PrimaryButton(
                    label: _isLoading ? "PLEASE WAIT..." : "REGISTER",
                    onPressed: _isLoading ? () {} : _onRegister,
                  ),

                  const SizedBox(height: 16),

                  // ---------------- Login Link ----------------
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: cs.onSurface),
                      children: [
                        const TextSpan(text: "Already have an account? "),
                        TextSpan(
                          text: "Login",
                          style: TextStyle(
                            color: cs.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              context.push(AppRoutes.login);
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
