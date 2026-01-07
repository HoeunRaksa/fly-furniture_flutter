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
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: activeColor.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: CupertinoColors.black.withOpacity(isDark ? 0.3 : 0.06),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                    CupertinoColors.systemGrey6.darkColor.withOpacity(0.8),
                    CupertinoColors.systemGrey6.darkColor.withOpacity(0.7),
                  ]
                      : [
                    Colors.white.withOpacity(0.85),
                    Colors.white.withOpacity(0.75),
                  ],
                ),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.white.withOpacity(0.5),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(24),
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
                    icon: Icon(
                      CupertinoIcons.house,
                      color: _currentIndex == 0 ? activeColor : inactiveColor,
                      size: 24,
                    ),
                    selectedIcon: Icon(
                      CupertinoIcons.house_fill,
                      color: activeColor,
                      size: 24,
                    ),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      CupertinoIcons.heart,
                      color: _currentIndex == 1 ? activeColor : inactiveColor,
                      size: 24,
                    ),
                    selectedIcon: Icon(
                      CupertinoIcons.heart_fill,
                      color: activeColor,
                      size: 24,
                    ),
                    label: 'Favorite',
                  ),
                  NavigationDestination(
                    icon: Badge(
                      label: const Text('3'),
                      backgroundColor: CupertinoColors.systemRed,
                      child: Icon(
                        CupertinoIcons.cart,
                        color: _currentIndex == 2 ? activeColor : inactiveColor,
                        size: 24,
                      ),
                    ),
                    selectedIcon: Badge(
                      label: const Text('3'),
                      backgroundColor: CupertinoColors.systemRed,
                      child: Icon(
                        CupertinoIcons.cart_fill,
                        color: activeColor,
                        size: 24,
                      ),
                    ),
                    label: 'Cart',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      CupertinoIcons.person,
                      color: _currentIndex == 3 ? activeColor : inactiveColor,
                      size: 24,
                    ),
                    selectedIcon: Icon(
                      CupertinoIcons.person_fill,
                      color: activeColor,
                      size: 24,
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}