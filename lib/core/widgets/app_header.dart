import 'package:flutter/material.dart';
import 'package:fly/core/widgets/circleIcon_button.dart';
import 'package:fly/core/widgets/input_field.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_color.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  final String nameScreen;
  final bool suffixIcon;
  final void Function(String)? onChanged;


  const AppHeader({
    super.key,
    required this.nameScreen,
    this.suffixIcon = false,
    this.onChanged
  });

  @override
  State<AppHeader> createState() => _AppHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(150);
}

class _AppHeaderState extends State<AppHeader> {
  bool isSearching = false;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (widget.suffixIcon)
              CircleIconButton(
                icon: Icons.arrow_back_ios,
                backgroundColor: AppColors.primary,
                iconSize: 25,
                sizedY: 44,
                sizeX: 44,
                onTap: () => context.pop(),
              ),

            /// TITLE OR SEARCH FIELD
            Expanded(
              child: isSearching
                  ? InputField(
                label: "Search product",
                onChanged: widget.onChanged,
              )
                  : Text(
                widget.nameScreen,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  color: AppColors.furnitureBlue,
                ),
              ),
            ),

            /// SEARCH / CLOSE BUTTON
            if (!widget.suffixIcon)
              CircleIconButton(
                icon: isSearching ? Icons.close : Icons.search,
                backgroundColor: AppColors.primary,
                iconSize: 25,
                sizedY: 44,
                sizeX: 44,
                onTap: () {
                  setState(() {
                    if (isSearching) {
                      // ✅ closing search → clear text + notify parent
                      controller.clear();
                      widget.onChanged?.call('');
                    }
                    isSearching = !isSearching;
                  });
                },
              ),

            if (widget.suffixIcon)
              const SizedBox(height: 44, width: 44),
          ],
        ),
      ),
    );
  }
}
