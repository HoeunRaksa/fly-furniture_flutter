import 'package:flutter/material.dart';
import 'package:fly/core/routing/app_router.dart';
import 'package:provider/provider.dart';

import 'config/app_theme.dart';
import 'features/auth/provider/auth_provider.dart';
import 'providers/product_provider.dart';
import 'features/auth/provider/user_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Do NOT use Consumer3 here directly at root
    return Builder(
      builder: (context) {
        final authProvider = context.watch<AuthProvider>();
        final productProvider = context.watch<ProductProvider>();
        final userProvider = context.watch<UserProvider>();

        final router = AppRouter.router(authProvider, productProvider);

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
        );
      },
    );
  }
}
