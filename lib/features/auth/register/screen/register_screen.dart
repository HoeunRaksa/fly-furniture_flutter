import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../config/app_color.dart';
import '../../../../core/routing/app_routes.dart';
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

  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

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
      router.push(AppRoutes.verifyEmail, extra: {'email': _emailCtrl.text.trim()});
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppColors.saleRed,
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Create Account", style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.headerLine, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What's your name?",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.headerLine, letterSpacing: -1.0),
                ),
                const SizedBox(height: 8),
                Text(
                  "Enter your details to join the FLY Furniture community.",
                  style: TextStyle(fontSize: 15, color: AppColors.bodyLine),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstNameCtrl,
                        decoration: _inputDecoration("First name"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _lastNameCtrl,
                        decoration: _inputDecoration("Last name"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailCtrl,
                  decoration: _inputDecoration("Email address"),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordCtrl,
                  obscureText: true,
                  decoration: _inputDecoration("Password"),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _isLoading ? null : _onRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.furnitureBlue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: Text(
                    _isLoading ? "CREATING..." : "GET STARTED",
                    style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.0),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: TextButton(
                    onPressed: () => context.pop(),
                    child: Text(
                      "Already have an account?",
                      style: TextStyle(color: AppColors.furnitureBlue, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      fillColor: AppColors.secondary,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.divider),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.furnitureBlue, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      labelStyle: const TextStyle(color: AppColors.bodyLine, fontWeight: FontWeight.w500),
      floatingLabelStyle: const TextStyle(color: AppColors.furnitureBlue, fontWeight: FontWeight.w700),
    );
  }
}
