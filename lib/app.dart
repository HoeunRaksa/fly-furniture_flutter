import 'package:flutter/material.dart';
import 'package:fly/core/routing/app_router.dart';
import 'package:provider/provider.dart';

import 'config/app_theme.dart';
import 'features/auth/provider/auth_provider.dart';
import 'providers/product_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Consumer2 to get both providers
    return Consumer2<AuthProvider, ProductProvider>(
      builder: (context, authProvider, productProvider, _) {
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
