import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fly/config/app_color.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/routing/app_routes.dart';
import '../../provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  
  bool _isLoading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await context.read<AuthProvider>().login(
        _emailCtrl.text.trim(),
        _passwordCtrl.text.trim(),
      );

      if (!mounted) return;
      router.go(AppRoutes.home);
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // FLY Furniture Branding - Furniture Specific
              Container(
                height: 250,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "You’re back already!",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w500,
                        color: AppColors.furnitureBlue, // Using the FB Blue for style consistency
                        letterSpacing: -2.0,
                      ),
                    ),
                    Text(
                      "ARCHITECTURAL FURNITURE",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.headerLine.withOpacity(0.4),
                        letterSpacing: 2.5,
                      ),
                    ),
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailCtrl,
                        decoration: InputDecoration(
                          hintText: "Email address",
                          fillColor: AppColors.secondary,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordCtrl,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          fillColor: AppColors.secondary,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _onLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.furnitureBlue,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        child: Text(
                          _isLoading ? "SIGNING IN..." : "SIGN IN",
                          style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1.0),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(color: AppColors.bodyLine, fontWeight: FontWeight.w600),
                        ),
                      ),
                      
                      const SizedBox(height: 40),
                      
                      OutlinedButton(
                        onPressed: () => context.push(AppRoutes.register),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 56),
                          side: BorderSide(color: AppColors.furnitureBlue.withOpacity(0.3)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Text(
                          "CREATE NEW ACCOUNT",
                          style: TextStyle(color: AppColors.furnitureBlue, fontWeight: FontWeight.w800, letterSpacing: 1.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
