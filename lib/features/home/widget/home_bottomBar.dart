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

  // Screens list
  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoriteScreen(),
    const ShoppingScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          height: 70,
          backgroundColor: Colors.white,
          elevation: 0,
          indicatorColor: Colors.orange.shade50,
          animationDuration: const Duration(milliseconds: 400),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: [
            NavigationDestination(
              icon: Icon(
                CupertinoIcons.home,
                color: _currentIndex == 0 ? Colors.orange.shade700 : Colors.grey.shade500,
              ),
              selectedIcon: Icon(
                CupertinoIcons.home,
                color: Colors.orange.shade700,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                CupertinoIcons.heart,
                color: _currentIndex == 1 ? Colors.orange.shade700 : Colors.grey.shade500,
              ),
              selectedIcon: Icon(
                CupertinoIcons.heart_fill,
                color: Colors.orange.shade700,
              ),
              label: 'Favorite',
            ),
            NavigationDestination(
              icon: Badge(
                label: const Text('3'),
                backgroundColor: Colors.red.shade600,
                child: Icon(
                  CupertinoIcons.shopping_cart,
                  color: _currentIndex == 2 ? Colors.orange.shade700 : Colors.grey.shade500,
                ),
              ),
              selectedIcon: Badge(
                label: const Text('3'),
                backgroundColor: Colors.red.shade600,
                child: Icon(
                  CupertinoIcons.cart_fill,
                  color: Colors.orange.shade700,
                ),
              ),
              label: 'Cart',
            ),
            NavigationDestination(
              icon: Icon(
                CupertinoIcons.person,
                color: _currentIndex == 3 ? Colors.orange.shade700 : Colors.grey.shade500,
              ),
              selectedIcon: Icon(
                CupertinoIcons.person_fill,
                color: Colors.orange.shade700,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder screens
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.heart_fill,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              'No favorites yet',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start adding items to your wishlist',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.trash),
            onPressed: () {
              // Clear cart
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.cart,
                    size: 80,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add items to get started',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Go to home
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Start Shopping'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}