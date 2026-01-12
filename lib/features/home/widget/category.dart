import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../config/app_color.dart';

class Category extends StatefulWidget {
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

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(Category oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index == widget.selectedIndex &&
        oldWidget.selectedIndex != widget.selectedIndex) {
      _controller.forward();
    } else if (widget.index != widget.selectedIndex &&
        oldWidget.selectedIndex == widget.index) {
      _controller.reverse();
    }
  }

  bool get isSelected => widget.index == widget.selectedIndex;

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
    final categoryData = widget.index < categories.length
        ? categories[widget.index]
        : categories[0];
    final displayName = widget.name ?? categoryData['name'];
    final displayIcon = widget.icon ?? categoryData['icon'];

    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: isSelected || _isHovered ? _scaleAnimation.value : 1.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: isSelected ? 12 : 8,
                  sigmaY: isSelected ? 12 : 8,
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: isSelected
                        ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.secondaryGreen.withValues(alpha: 0.9),
                        AppColors.greenDark.withValues(alpha: 0.8),
                      ],
                    )
                        : LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isDark
                          ? [
                        Colors.white.withValues(
                          alpha: _isHovered ? 0.15 : 0.1,
                        ),
                        Colors.white.withValues(
                          alpha: _isHovered ? 0.1 : 0.05,
                        ),
                      ]
                          : [
                        Colors.white.withValues(
                          alpha: _isHovered ? 0.95 : 0.85,
                        ),
                        Colors.white.withValues(
                          alpha: _isHovered ? 0.9 : 0.75,
                        ),
                      ],
                    ),
                    border: Border.all(
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.4)
                          : isDark
                          ? Colors.white.withValues(alpha: _isHovered ? 0.2 : 0.1)
                          : Colors.white.withValues(alpha: _isHovered ? 0.6 : 0.4),
                      width: isSelected ? 2 : 1.5,
                    ),
                    boxShadow: [
                      if (isSelected) ...[
                        BoxShadow(
                          color: AppColors.secondaryGreen.withValues(
                            alpha: 0.4 * _glowAnimation.value,
                          ),
                          blurRadius: 20,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                        BoxShadow(
                          color: AppColors.greenLight.withValues(
                            alpha: 0.3 * _glowAnimation.value,
                          ),
                          blurRadius: 30,
                          spreadRadius: 1,
                          offset: const Offset(0, 8),
                        ),
                      ] else ...[
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withValues(alpha: 0.3)
                              : Colors.black.withValues(
                            alpha: _isHovered ? 0.08 : 0.04,
                          ),
                          blurRadius: _isHovered ? 12 : 8,
                          offset: Offset(0, _isHovered ? 6 : 3),
                        ),
                      ],
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: widget.onTap,
                      borderRadius: BorderRadius.circular(18),
                      splashColor: isSelected
                          ? Colors.white.withValues(alpha: 0.15)
                          : AppColors.secondaryGreen.withValues(alpha: 0.1),
                      highlightColor: isSelected
                          ? Colors.white.withValues(alpha: 0.1)
                          : AppColors.secondaryGreen.withValues(alpha: 0.05),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedScale(
                              scale: isSelected ? 1.15 : 1.0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutBack,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                decoration: isSelected
                                    ? BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withValues(
                                        alpha: 0.5,
                                      ),
                                      blurRadius: 12,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                )
                                    : null,
                                child: TweenAnimationBuilder<double>(
                                  duration: const Duration(milliseconds: 400),
                                  tween: Tween(
                                    begin: 0.0,
                                    end: isSelected ? 1.0 : 0.0,
                                  ),
                                  curve: Curves.elasticOut,
                                  builder: (context, value, child) {
                                    return Transform.rotate(
                                      angle: value * 0.1,
                                      child: Icon(
                                        displayIcon,
                                        size: 20,
                                        color: isSelected
                                            ? Colors.white
                                            : isDark
                                            ? CupertinoColors.secondaryLabel
                                            .resolveFrom(context)
                                            : CupertinoColors.secondaryLabel
                                            .resolveFrom(context),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : CupertinoColors.label.resolveFrom(
                                  context,
                                ),
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                fontSize: isSelected ? 15 : 14,
                                letterSpacing: isSelected ? 0.3 : 0.1,
                                height: 1.2,
                                shadows: isSelected
                                    ? [
                                  Shadow(
                                    color: AppColors.secondaryGreen
                                        .withValues(alpha: 0.5),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                                    : [],
                              ),
                              child: Text(displayName),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}