import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({super.key});
  @override
  State<HomeBottomBar> createState() => _HomeBottomBar();
}
class _HomeBottomBar extends State<HomeBottomBar> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      backgroundColor: Colors.white,
      border: null,
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },

      items: [
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: "Home",
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.heart),
          label: "Favorite",
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.shopping_cart),
          label: 'Shopping',
        ),
        const BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.profile_circled),
          label: "Profile",
        ),
      ],
    );
  }
}
