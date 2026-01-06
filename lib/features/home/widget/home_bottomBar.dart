import 'dart:ui';
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
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const ProfileScreen(),
  ];

  final Color activeColor = CupertinoColors.systemOrange;
  final Color inactiveColor = CupertinoColors.systemGrey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              height: 70,
              backgroundColor: Colors.transparent,
              elevation: 0,
              indicatorColor: activeColor.withOpacity(0.12),
              animationDuration: const Duration(milliseconds: 350),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
                if (states.contains(MaterialState.selected)) {
                  return const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.systemOrange,
                  );
                } else {
                  return const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: CupertinoColors.systemGrey,
                  );
                }
              }),
              destinations: [
                NavigationDestination(
                  icon: Icon(CupertinoIcons.house, color: _currentIndex == 0 ? activeColor : inactiveColor),
                  selectedIcon: Icon(CupertinoIcons.house_fill, color: activeColor),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(CupertinoIcons.heart, color: _currentIndex == 1 ? activeColor : inactiveColor),
                  selectedIcon: Icon(CupertinoIcons.heart_fill, color: activeColor),
                  label: 'Favorite',
                ),
                NavigationDestination(
                  icon: Badge(
                    label: const Text('3'),
                    backgroundColor: CupertinoColors.systemRed,
                    child: Icon(CupertinoIcons.cart, color: _currentIndex == 2 ? activeColor : inactiveColor),
                  ),
                  selectedIcon: Badge(
                    label: const Text('3'),
                    backgroundColor: CupertinoColors.systemRed,
                    child: Icon(CupertinoIcons.cart_fill, color: activeColor),
                  ),
                  label: 'Cart',
                ),
                NavigationDestination(
                  icon: Icon(CupertinoIcons.person, color: _currentIndex == 3 ? activeColor : inactiveColor),
                  selectedIcon: Icon(CupertinoIcons.person_fill, color: activeColor),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
