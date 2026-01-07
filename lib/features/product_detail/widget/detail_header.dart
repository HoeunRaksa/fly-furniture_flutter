import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../ui/button_header.dart';

class DetailHeader extends StatelessWidget {
  const DetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
            CupertinoColors.black.withOpacity(0.8),
            CupertinoColors.black.withOpacity(0.4),
            CupertinoColors.black.withOpacity(0.0),
          ]
              : [
            CupertinoColors.systemBackground.withOpacity(0.8),
            CupertinoColors.systemBackground.withOpacity(0.4),
            CupertinoColors.systemBackground.withOpacity(0.0),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            child: ButtonHeader(
              onClickedBack: () => context.pop(),
            ),
          )
        ],
      ),
    );
  }
}