import 'package:fly/core/routing/app_routes.dart';
import 'package:fly/features/auth/login/ui/login_screen.dart';
import 'package:fly/features/auth/otpVerify/ui/otp_screen.dart';
import 'package:fly/features/auth/register/ui/register_screen.dart';
import 'package:fly/features/home/ui/home_screen.dart';
import 'package:fly/features/product_detail/ui/product_screen.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';

class AppRouter {
  static GoRouter router(AuthProvider authProvider, ProductProvider productProvider) => GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.verifyEmail,
        builder: (context, state) => const OtpVerification(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '${AppRoutes.detail}/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;

          // Use ProductProvider to find the product by ID
          final product = productProvider.products.firstWhere(
                (p) => p.id.toString() == id,
            orElse: () => throw Exception("Product not found"),
          );

          return ProductScreen(product: product);
        },
      ),
    ],
    // Optional redirect logic
    // redirect: (context, state) {
    //   final loggedIn = authProvider.isLoggedIn;
    //   final currentPath = state.uri.path;
    //   if (loggedIn && currentPath == AppRoutes.login) return AppRoutes.home;
    //   if (!loggedIn && currentPath == AppRoutes.home) return AppRoutes.login;
    //   return null;
    // },
  );
}
