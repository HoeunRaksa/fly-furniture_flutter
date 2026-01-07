import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../config/app_color.dart';

class Category extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final VoidCallback onTap;
  final String? name;
  final IconData? icon;

  const Category({
    super.key,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
    this.name,
    this.icon,
  });

  bool get isSelected => index == selectedIndex;

  // Category data
  static final List<Map<String, dynamic>> categories = [
    {'name': 'All', 'icon': Icons.grid_view_rounded},
    {'name': 'Chair', 'icon': Icons.chair_outlined},
    {'name': 'Table', 'icon': Icons.table_restaurant_outlined},
    {'name': 'Sofa', 'icon': Icons.weekend_outlined},
    {'name': 'Bed', 'icon': Icons.bed_outlined},
    {'name': 'Lamp', 'icon': Icons.lightbulb_outline},
    {'name': 'Storage', 'icon': Icons.shelves},
    {'name': 'Desk', 'icon': Icons.desk_outlined},
    {'name': 'Outdoor', 'icon': Icons.yard_outlined},
    {'name': 'Kitchen', 'icon': Icons.kitchen_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    // Get category data
    final categoryData = index < categories.length
        ? categories[index]
        : categories[0];
    final displayName = name ?? categoryData['name'];
    final displayIcon = icon ?? categoryData['icon'];

    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: isSelected
            ? LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondaryGreen,
            AppColors.secondaryGreen.withOpacity(0.85),
          ],
        )
            : LinearGradient(
          colors: [
            Colors.white.withOpacity(0.95),
            Colors.white.withOpacity(0.9),
          ],
        ),
        border: Border.all(
          color: isSelected
              ? Colors.white.withOpacity(0.3)
              : CupertinoColors.separator.resolveFrom(context).withOpacity(0.2),
          width: isSelected ? 1.5 : 0.5,
        ),
        boxShadow: isSelected
            ? [
          BoxShadow(
            color: AppColors.secondaryGreen.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppColors.secondaryGreen.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ]
            : [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: isSelected
              ? Colors.white.withOpacity(0.1)
              : AppColors.secondaryGreen.withOpacity(0.05),
          highlightColor: isSelected
              ? Colors.white.withOpacity(0.05)
              : AppColors.secondaryGreen.withOpacity(0.03),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: isSelected ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: isSelected
                        ? BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    )
                        : null,
                    child: Icon(
                      displayIcon,
                      size: 20,
                      color: isSelected
                          ? Colors.white
                          : CupertinoColors.secondaryLabel.resolveFrom(context),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  displayName,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : CupertinoColors.label.resolveFrom(context),
                    fontWeight: isSelected
                        ? FontWeight.w400
                        : FontWeight.w400,
                    fontSize: 14,
                    letterSpacing: isSelected ? 0.2 : 0.1,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}