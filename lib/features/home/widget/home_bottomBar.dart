import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly/features/favorite/screen/favorite_screen.dart';
import 'package:fly/features/profile/screen/profile_screen.dart';
import '../../../config/app_color.dart';
import '../screen/home_screen.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({super.key});

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    FavoriteScreen(favorites: const []),
    const HomeScreen(), // Placeholder for Cart
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: _buildFurnitureBottomBar(),
    );
  }

  Widget _buildFurnitureBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.divider,
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: Container(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabItem(0, CupertinoIcons.house_fill, "Home"),
              _buildTabItem(1, CupertinoIcons.heart_fill, "Favorites"),
              _buildTabItem(2, CupertinoIcons.bag_fill, "Cart", badgeCount: 3),
              _buildTabItem(3, CupertinoIcons.person_fill, "Profile"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(int index, IconData icon, String label, {int? badgeCount}) {
    bool isSelected = _currentIndex == index;
    Color color = isSelected ? AppColors.furnitureBlue : AppColors.bodyLine.withOpacity(0.5);

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            // Active top indicator in Furniture Blue
            Container(
              height: 3,
              width: 36,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.furnitureBlue : Colors.transparent,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(3)),
              ),
            ),
            const Spacer(),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
                if (badgeCount != null)
                  Positioned(
                    top: -4,
                    right: -6,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: AppColors.saleRed,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        badgeCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
