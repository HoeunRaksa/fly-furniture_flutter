import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fly/features/card/screen/cardScreen.dart';
import 'package:fly/features/favorite/screen/favorite_screen.dart';
import 'package:fly/features/profile/screen/profile_screen.dart';
import '../../../config/app_color.dart';
import '../screen/home_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  bool _isBottomBarVisible = true;


  final List<Widget> _screens = [
    const HomeScreen(),
    FavoriteScreen(),
    const CardScreen(),
    const ProfileScreen(isSetHeader: true),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.reverse) {
              if (_isBottomBarVisible) {
                setState(() => _isBottomBarVisible = false);
              }
            } else if (notification.direction == ScrollDirection.forward) {
              if (!_isBottomBarVisible) {
                setState(() => _isBottomBarVisible = true);
              }
            }
            return true;
          },
          child: IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
        ),
      bottomNavigationBar: AnimatedSize(
        duration: const Duration(milliseconds: 380),
        curve: Curves.easeInOut,
        child: SizedBox(
          height: _isBottomBarVisible ? 70 : 0,
          child: _buildFBStyleBottomBar(),
        ),
      ),

    );
        }

  Widget _buildFBStyleBottomBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: const Color(0xFFE4E6EB),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 54,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFBTabItem(0, CupertinoIcons.house_fill, "Home"),
              _buildFBTabItem(1, CupertinoIcons.heart_fill, "Favorites"),
              _buildFBTabItem(2, CupertinoIcons.bag_fill, "Card", badgeCount: 3),
              _buildFBTabItem(3, CupertinoIcons.person_fill, "Profile"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFBTabItem(int index, IconData icon, String label, {int? badgeCount}) {
    bool isSelected = _currentIndex == index;
    Color color = isSelected ? AppColors.furnitureBlue : const Color(0xFF65676B);

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            Container(
              height: 3,
              width: 40,
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
                  size: 26,
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
