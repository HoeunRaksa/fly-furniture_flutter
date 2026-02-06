import 'package:flutter/material.dart';
import 'package:fly/core/routing/app_routes.dart';
import 'package:fly/features/auth/welcome/welcome_screen.dart';
import 'package:fly/features/home/widget/home_bottomBar.dart';
import 'package:fly/features/profile/screen/profile_screen.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/login/screen/login_screen.dart';
import '../../features/auth/otpVerify/screen/otp_screen.dart';
import '../../features/auth/provider/auth_provider.dart';
import '../../features/auth/register/screen/register_screen.dart';
import '../../features/product_detail/screen/product_screen.dart';
import '../../providers/product_provider.dart';

class AppRouter {
  static GoRouter router(AuthProvider authProvider, ProductProvider productProvider) {
    return GoRouter(
      initialLocation: AppRoutes.welcome, // ✅ start here
      refreshListenable: authProvider,
      routes: [
        GoRoute(
          path: AppRoutes.welcome,
          builder: (context, state) => const WelcomeScreen(),
        ),
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
          builder: (context, state) {
            final email = (state.extra as Map?)?['email'] as String?;
            final finalEmail = email ?? authProvider.user?.email;

            if (finalEmail == null || finalEmail.isEmpty) {
              return const Scaffold(
                body: Center(child: Text("Email is required")),
              );
            }
            return OtpVerification(email: finalEmail);
          },
        ),
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeBottomBar(),
        ),
        GoRoute(
          path: '${AppRoutes.detail}/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;

            final product = productProvider.products.firstWhere(
                  (p) => p.id.toString() == id,
              orElse: () => throw Exception("Product not found"),
            );

            return ProductScreen(product: product);
          },
        ),
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => const ProfileScreen(isSetHeader: true),
        ),
      ],

      redirect: (context, state) {
        final currentPath = state.uri.path;

        // ✅ wait until token load finished
        if (!authProvider.sessionLoaded) {
          // allow welcome while loading
          return currentPath == AppRoutes.welcome ? null : AppRoutes.welcome;
        }

        final loggedIn = authProvider.isLoggedIn; // ✅ token-based
        final otpPending = authProvider.otpPending;

        // OTP flow
        if (otpPending && currentPath != AppRoutes.verifyEmail) {
          return AppRoutes.verifyEmail;
        }

        // public pages
        final isPublic = currentPath == AppRoutes.welcome ||
            currentPath == AppRoutes.login ||
            currentPath == AppRoutes.register ||
            currentPath == AppRoutes.verifyEmail;

        // protected pages
        final isProtected = currentPath.startsWith(AppRoutes.home) ||
            currentPath.startsWith(AppRoutes.profile) ||
            currentPath.startsWith(AppRoutes.detail);

        if (!loggedIn && isProtected) {
          return AppRoutes.login;
        }

        if (loggedIn && isPublic && currentPath != AppRoutes.verifyEmail) {
          return AppRoutes.home;
        }

        return null;
      },
    );
  }
}
