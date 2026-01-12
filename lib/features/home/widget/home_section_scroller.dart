import 'dart:async';
import 'package:flutter/material.dart';
import '../../../config/app_config.dart';

class HomeSectionScroller extends StatefulWidget {
  const HomeSectionScroller({super.key});

  @override
  State<HomeSectionScroller> createState() => _HomeSectionScrollerState();
}

class _HomeSectionScrollerState extends State<HomeSectionScroller> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  // Banner data
  final List<Map<String, dynamic>> banners = [
    {
      'title': 'Discount 80%',
      'subtitle': 'Best deals',
      'image': '${AppConfig.imageUrl}/firstHeader.png',
      'gradient': [Colors.purple.shade700, Colors.deepPurple.shade900],
    },
    {
      'title': 'New Arrivals',
      'subtitle': 'Fresh styles',
      'image': '${AppConfig.imageUrl}/banner.png',
      'gradient': [Colors.orange.shade600, Colors.deepOrange.shade800],
    },
    {
      'title': 'Summer Sale',
      'subtitle': 'Up to 50% off',
      'image': '${AppConfig.imageUrl}/character.png',
      'gradient': [Colors.teal.shade600, Colors.cyan.shade800],
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.9,
      initialPage: 0,
    );
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || !_pageController.hasClients) return;

      final nextPage = (_currentPage + 1) % banners.length;

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubicEmphasized,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 600;
    final cardHeight = isLargeScreen ? 200.0 : 160.0;

    return Column(
      children: [
        SizedBox(
          height: cardHeight,
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              if (mounted) {
                setState(() {
                  _currentPage = index % banners.length;
                });
              }
            },
            itemCount: banners.length * 1000, // Infinite scroll effect
            itemBuilder: (context, index) {
              final banner = banners[index % banners.length];
              final realIndex = index % banners.length;

              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.15)).clamp(0.85, 1.0);
                  }

                  return Transform.scale(
                    scale: value,
                    child: Opacity(
                      opacity: value,
                      child: child,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: GestureDetector(
                    onTap: () {
                      debugPrint('Banner tapped: ${banner['title']}');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: banner['gradient'],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: banner['gradient'][0].withValues(alpha: 0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            // Gradient overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withValues(alpha: 0.3),
                                      Colors.transparent,
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),

                            // Content
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Title
                                    Text(
                                      banner['title'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isLargeScreen ? 26 : 20,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: -0.5,
                                        height: 1.0,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withValues(alpha: 0.4),
                                            offset: const Offset(0, 2),
                                            blurRadius: 4,
                                          ),
                                        ],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    const SizedBox(height: 6),

                                    // Subtitle
                                    Text(
                                      banner['subtitle'],
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.9),
                                        fontSize: isLargeScreen ? 12 : 11,
                                        height: 1.0,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black.withValues(alpha: 0.3),
                                            offset: const Offset(0, 1),
                                            blurRadius: 2,
                                          ),
                                        ],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    const SizedBox(height: 12),

                                    // CTA Button
                                    SizedBox(
                                      height: 32,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          debugPrint('Shop Now: ${banner['title']}');
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: banner['gradient'][0],
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 0,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          elevation: 3,
                                          minimumSize: Size.zero,
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Shop Now",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11,
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Icon(Icons.arrow_forward, size: 12),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Page indicators
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
                (index) {
              final isActive = index == _currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: isActive ? 24 : 8,
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.orange.shade700
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: isActive
                      ? [
                    BoxShadow(
                      color: Colors.orange.shade700.withValues(alpha: 0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                      : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}