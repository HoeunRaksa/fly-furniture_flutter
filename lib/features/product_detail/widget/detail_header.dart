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