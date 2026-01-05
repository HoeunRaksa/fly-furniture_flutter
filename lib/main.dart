import 'package:flutter/material.dart';
import 'package:fly/app.dart';
import 'features/auth/provider/auth_provider.dart';
import 'features/auth/provider/user_provider.dart';
import 'providers/product_provider.dart';
import 'features/auth/service/user_service.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        // AuthProvider keeps the token & user after login
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        // UserProvider depends on AuthProvider
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (context) {
            final auth = context.read<AuthProvider>();
            return UserProvider(
              userService: UserService(), // token passed per method
              authProvider: auth,
            );
          },
          update: (_, authProvider, userProvider) {
            // UserProvider already has reference to authProvider
            return userProvider!;
          },
        ),

        // ProductProvider
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
