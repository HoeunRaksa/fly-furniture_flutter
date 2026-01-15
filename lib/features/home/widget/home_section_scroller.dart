import 'dart:async';
import 'package:flutter/material.dart';
import '../../../config/app_config.dart';

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
    final isLargeScreen = MediaQuery.of(context).size.width > 500;
    final height = isLargeScreen ? 200.0 : 160.0;

    return Column(
      children: [
        SizedBox(
          height: height,
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
                    width: double.infinity, // ✅ FULL WIDTH
                    margin: EdgeInsets.zero, // ✅ NO PADDING
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: banner['gradient'],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: banner['gradient'][0].withOpacity(0.25),
                          blurRadius: 18,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          // Dark overlay
                          Positioned.fill(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.35),
                                    Colors.transparent,
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),

                          // Content
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  banner['title'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isLargeScreen ? 26 : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  banner['subtitle'],
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: isLargeScreen ? 12 : 11,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  height: 32,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: banner['gradient'][0],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 3,
                                    ),
                                    child: const Text(
                                      "Shop Now",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ),
                                ),
                              ],
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
                    ? Colors.orange.shade700
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
