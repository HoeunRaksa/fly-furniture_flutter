import 'package:flutter/cupertino.dart';
import 'package:fly/app.dart';
import 'package:fly/features/auth/provider/auth_provider.dart';
import 'package:fly/providers/product_provider.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(
      MultiProvider(
     providers: [
         ChangeNotifierProvider(create:(_) => AuthProvider()),
         ChangeNotifierProvider(create: (_)=> ProductProvider())
     ],
        child: const MyApp(),
  ));
}