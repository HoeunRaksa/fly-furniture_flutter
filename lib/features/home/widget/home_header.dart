import 'package:flutter/material.dart';
import 'package:fly/config/app_config.dart';
import 'package:fly/features/auth/provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../../../config/app_color.dart';
import '../../../core/widgets/input_field.dart';

class HomeHeader extends StatelessWidget implements PreferredSizeWidget {
  const HomeHeader({super.key, required this.onSearchChanged});
  final void Function(String) onSearchChanged;

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final user = userProvider.user;
    final userName = user?.name ?? "Guest";

    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.gray700.withAlpha(20), width: 1),
        ),
        padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Display user profile image if exists, else placeholder
                CircleAvatar(
                  radius: 35,
                  backgroundImage: user?.profileImage != null
                      ? NetworkImage(AppConfig.getImageUrl(user!.profileImage!))
                      : AssetImage("${AppConfig.imageUrl}/character.png")
                  as ImageProvider,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Welcome",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        userName,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gray700.withAlpha(50),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: InputField(
                label: "Search",
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors.gray700.withAlpha(190),
                ),
                onChanged: onSearchChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(150);
}
