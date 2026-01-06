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

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: isSelected ? AppColors.secondaryGreen : Colors.white,
        border: Border.all(
          color: isSelected ? Colors.white : Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedScale(
                  scale: isSelected ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    displayIcon,
                    size: 20,
                    color: isSelected
                        ? Colors.white
                        : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  displayName,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Colors.grey.shade700,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.w500,
                    fontSize: 14,
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