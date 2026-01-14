import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fly/config/app_config.dart';
import 'package:fly/features/auth/provider/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../config/app_color.dart';
import '../../../core/widgets/input_field.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeader({super.key, required this.onSearchChanged});
  final void Function(String) onSearchChanged;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user;
    final userName = user?.name ?? "Guest";

    String capitalizeFirst(String? text) {
      if (text == null || text.isEmpty) return '';
      return text[0].toUpperCase() + text.substring(1);
    }
    return PreferredSize(
      preferredSize: preferredSize,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: AppColors.offWhite, width: 1),
            ),
            padding: const EdgeInsets.fromLTRB(24, 1, 24, 10),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // Top Row: Avatar, Welcome, Notifications
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Avatar
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        minSize: 0,
                        onPressed: () => context.push("/profile"),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.offWhite,
                                boxShadow: [
                                  BoxShadow(
                                    color: CupertinoColors.systemBlue.withOpacity(0.15),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: CircleAvatar(
                                  radius: 23,
                                  backgroundColor: CupertinoColors.systemGrey6.resolveFrom(context),
                                  backgroundImage: user?.hasProfileImage == true
                                      ? CachedNetworkImageProvider(
                                    user!.profileImageUrl!,
                                  )
                                      : const AssetImage("${AppConfig.imageUrl}/character.png") as ImageProvider,
                                ),
                              ),
                            ),
                            // Online Indicator with glow
                            Positioned(
                              bottom: 2,
                              right: 2,
                              child: Container(
                                width: 13,
                                height: 13,
                                decoration: BoxDecoration(
                                  color: CupertinoColors.activeGreen,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                                    width: 2.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: CupertinoColors.activeGreen.withOpacity(0.5),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 18),

                      // Welcome Text
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppColors.woodDeep,
                                letterSpacing: -0.5,
                                height: 1.1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5,),
                            Text(
                              capitalizeFirst(userName),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.woodDeep,
                                letterSpacing: -0.5,
                                height: 1.1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      // Notifications Button with glass effect
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: CupertinoColors.white.withOpacity(0.2),
                                    width: 0.5,
                                  ),
                                ),
                                child: CupertinoButton(
                                  padding: const EdgeInsets.all(11),
                                  minSize: 0,
                                  borderRadius: BorderRadius.circular(16),
                                  onPressed: () {
                                    debugPrint('Open notifications');
                                  },
                                  child: Icon(
                                    Icons.mail,
                                    size: 27,
                                    color: AppColors.woodLight,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Search Bar with glass morphism
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              CupertinoColors.systemFill.resolveFrom(context).withOpacity(0.4),
                              CupertinoColors.secondarySystemFill.resolveFrom(context).withOpacity(0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: CupertinoColors.separator.resolveFrom(context).withOpacity(0.3),
                            width: 0.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: CupertinoColors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: InputField(
                          label: "Search products...",
                          onChanged: onSearchChanged,
                        ),
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
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}