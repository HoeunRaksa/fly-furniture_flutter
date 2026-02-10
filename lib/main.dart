import 'package:flutter/material.dart';
import 'package:fly/app.dart';
import 'package:fly/providers/cardProvider.dart';
import 'package:fly/providers/category_provider.dart';
import 'package:fly/providers/favorite_provider.dart';
import 'features/auth/provider/auth_provider.dart';
import 'providers/product_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (FlutterErrorDetails details) {
    final exception = details.exception.toString();
    if (exception.contains('TooltipState') &&
        exception.contains('SingleTickerProviderStateMixin')) {
      return;
    }
    FlutterError.presentError(details);
  };

  runApp(
    MultiProvider(
      providers: [
        // AuthProvider manages authentication and user data
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        // ProductProvider manages product data
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        
        //ProductCategories management
        ChangeNotifierProvider(create: (_) => CategoryProvider()),

        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        
        ChangeNotifierProvider(create: (context) => CardProvider()),
      ],
      child: const MyApp(),
    ),
  );
}