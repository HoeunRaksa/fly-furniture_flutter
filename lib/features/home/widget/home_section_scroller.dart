import 'dart:async';
import 'package:flutter/material.dart';
import '../../../config/app_config.dart';

class HomeSectionScroller extends StatefulWidget {
  const HomeSectionScroller({super.key});

  @override
  State<HomeSectionScroller> createState() => _HomeHeaderAutoScroller();
}

class _HomeHeaderAutoScroller extends State<HomeSectionScroller> {
  final PageController _pageController = PageController(viewportFraction: 0.99);
  Timer? _timer;
  final int _totalPages = 3;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients) {
        _pageController.jumpToPage(1000);
      }
    });
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_pageController.hasClients) return;

      _pageController.nextPage(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
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
    final cardHeight = isLargeScreen ? 220.0 : 160.0;

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: SizedBox(
          height: cardHeight,
          child: PageView.builder(
            controller: _pageController,
            itemBuilder: (context, index) {
              final actualIndex = index % _totalPages;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "${AppConfig.imageUrl}/firstHeader.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 25,
                      top: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Discount 80%",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            "The best thing you have never seen before",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
