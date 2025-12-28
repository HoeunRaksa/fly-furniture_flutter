import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../config/app_color.dart';
import '../../../config/app_config.dart';

class HomeSectionScroller extends StatefulWidget {
  const HomeSectionScroller({super.key});

  @override
  State<HomeSectionScroller> createState() => _HomeHeaderAutoScroller();
}

class _HomeHeaderAutoScroller extends State<HomeSectionScroller> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  double scrollPosition = 0.0;
  bool scrollForward = true;
  final double itemWidth = 398;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_scrollController.hasClients) return;

      final maxExtent = _scrollController.position.maxScrollExtent;

      if (scrollForward) {
        scrollPosition += itemWidth;
        if (scrollPosition >= maxExtent) {
          scrollPosition = maxExtent;
          scrollForward = false;
        }
      } else {
        scrollPosition -= itemWidth;
        if (scrollPosition <= 0) {
          scrollPosition = 0;
          scrollForward = true;
        }
      }

      _scrollController.animateTo(
        scrollPosition,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.zero,
          child: Stack(
            children: [
              Container(
                width: 390,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gray700.withAlpha(50),
                      blurRadius: 40,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "${AppConfig.imageUrl}/firstHeader.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Discount 80%",
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge!.copyWith(color: Colors.white),
                    ),
                    Text(
                      "The best thing you have never seen before",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(width: 10),
      ),
    );
  }
}
