import 'package:flutter/material.dart';
import 'package:fly/app.dart';
import 'features/auth/provider/auth_provider.dart';
import 'providers/product_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Suppress harmless tooltip ticker errors from Flutter framework
  FlutterError.onError = (FlutterErrorDetails details) {
    final exception = details.exception.toString();

    // Ignore known harmless errors
    if (exception.contains('TooltipState') &&
        exception.contains('SingleTickerProviderStateMixin')) {
      // This is a Flutter framework issue, not our code - safe to ignore
      return;
    }

    // Show all other errors normally
    FlutterError.presentError(details);
  };

  runApp(
    MultiProvider(
      providers: [
        // AuthProvider manages authentication and user data
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        // ProductProvider manages product data
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  );
}