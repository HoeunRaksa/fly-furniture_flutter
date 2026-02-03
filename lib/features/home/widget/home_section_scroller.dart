import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../config/app_config.dart';
import '../../../config/app_color.dart';

class HomeSectionScroller extends StatefulWidget {
  const HomeSectionScroller({super.key});

  @override
  State<HomeSectionScroller> createState() => _HomeSectionScrollerState();
}

class _HomeSectionScrollerState extends State<HomeSectionScroller> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  final List<Map<String, dynamic>> banners = [
    {
      'title': 'The Oak Collection',
      'subtitle': 'Timeless wooden furniture',
      'image': 'assets/images/luxury_oak_banner.png',
      'accent': const Color(0xFF8B5E3C),
    },
    {
      'title': 'Minimalist Living',
      'subtitle': 'Scandi-inspired designs',
      'image': 'assets/images/scandi_living_banner.png',
      'accent': const Color(0xFF6B705C),
    },
    {
      'title': 'Terracotta Accents',
      'subtitle': 'Warm up your home',
      'image': 'assets/images/terracotta_lounge_banner.png',
      'accent': const Color(0xFFBC6C25),
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 1.0, // ✅ FULL WIDTH
    );
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_pageController.hasClients) return;
      final next = (_currentPage + 1) % banners.length;
      _pageController.animateToPage(
        next,
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
    // Import AppColors within build or use static reference
    // Since this file might not have imported app_color.dart, let's check
    final isLargeScreen = MediaQuery.of(context).size.width > 500;
    final double scrollerHeight = isLargeScreen ? 260.0 : 220.0;

    return Column(
      children: [
        SizedBox(
          height: scrollerHeight,
          child: PageView.builder(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            itemCount: banners.length * 1000,
            onPageChanged: (i) => setState(() => _currentPage = i % banners.length),
            itemBuilder: (context, index) {
              final banner = banners[index % banners.length];

              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double scale = 1.0;
                  if (_pageController.position.haveDimensions) {
                    final diff = (_pageController.page ?? 0) - index;
                    scale = (1 - diff.abs() * 0.04).clamp(0.96, 1.0);
                  }
                  return Transform.scale(scale: scale, child: child);
                },
                child: GestureDetector(
                  onTap: () => debugPrint('Banner tapped: ${banner['title']}'),
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: (banner['accent'] as Color).withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        children: [
                          // Background Image
                          Positioned.fill(
                            child: Image.asset(
                              banner['image'],
                              fit: BoxFit.cover,
                            ),
                          ),

                          // Sophisticated Overlay
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.6),
                                    Colors.black.withOpacity(0.1),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                            ),
                          ),

                          // Content aligned to bottom left with scale protection
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.all(isLargeScreen ? 24 : 16),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      banner['title'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isLargeScreen ? 28 : 22,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: -0.5,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      banner['subtitle'],
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.9),
                                        fontSize: isLargeScreen ? 14 : 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    CupertinoButton(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 6,
                                      ),
                                      color: Colors.white,
                                      minSize: 0,
                                      borderRadius: BorderRadius.circular(8),
                                      onPressed: () {},
                                      child: Text(
                                        "Explore Now",
                                        style: TextStyle(
                                          color: banner['accent'],
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
                (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: _currentPage == i ? 24 : 8,
              decoration: BoxDecoration(
                color: _currentPage == i
                    ? AppColors.accentButton
                    : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
