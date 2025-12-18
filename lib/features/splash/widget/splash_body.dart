import 'package:flutter/material.dart';
import '../../../core/colors/app_color.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Text(
            "Discover your Dream\nlife-style here",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blueGrey[800],
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Explore a wide range of fashion styles\ncrafted for your unique personality.\nShop the latest trends and make them yours!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blueGrey[700],
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
