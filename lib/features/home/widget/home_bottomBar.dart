import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly/features/profile/screen/profile_screen.dart';
import '../screen/home_screen.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({super.key});

  @override
  State<HomeBottomBar> createState() => _HomeBottomBar();
}

class _HomeBottomBar extends State<HomeBottomBar> {
  final int _currentIndex = 0;
  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen(); // real Home screen
      case 1:
        return const Center(child: Text("Favorite Screen")); // placeholder
      case 2:
        return const Center(child: Text("Shopping Screen")); // placeholder
      case 3:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        height: 60,
        backgroundColor: Colors.white,
        border: null,
        currentIndex: _currentIndex,
        activeColor: Colors.orangeAccent,
        inactiveColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            label: 'Shopping',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.profile_circled),
            label: "Profile",
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (_) => _getScreen(index),
        );
      },
    );
  }
}
