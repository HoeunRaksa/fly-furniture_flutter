import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly/core/widgets/elevated_button.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../config/app_config.dart';
import '../../auth/provider/auth_provider.dart';
import '../../auth/provider/user_provider.dart';
class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  void _showLogoutDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          CupertinoDialogAction(
            child: const Text("Cancel"),
            onPressed: () => context.pop(),
          ),
          CupertinoDialogAction(
            child: const Text("Yes", style: TextStyle(color: CupertinoColors.destructiveRed)),
            onPressed: () async {
              context.pop();

              // Get providers
              final authProvider = context.read<AuthProvider>();
              final userProvider = context.read<UserProvider>();

              // 1. Logout from AuthProvider
              await authProvider.logout();

              // 2. Clear UserProvider
              userProvider.clear();

              // 3. Navigate to home
              if (context.mounted) {
                context.go("/home");
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Get user from UserProvider (has full profile data)
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    // ✅ Show loading if no user
    if (user == null) {
      return const Center(
        child: Text('Please log in'),
      );
    }

    String capitalizeFirst(String? text) {
      if (text == null || text.isEmpty) return '';
      return text[0].toUpperCase() + text.substring(1);
    }

    final ImageProvider imageProvider =
    user.profileImage != null && user.profileImage!.isNotEmpty
        ? NetworkImage(AppConfig.getImageUrl(user.profileImage!))
        : const AssetImage("${AppConfig.imageUrl}/character.png");

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                // ✅ Debug info (remove in production)
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Current: ${user.email}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),

                // Profile Image
                SizedBox(
                  height: 140,
                  width: 140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: Image(image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  capitalizeFirst(user.name),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  user.email ?? '', // ✅ Show email
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: CupertinoColors.systemGrey,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    item(context, CupertinoIcons.person, "Personal Information",
                        onPress: () {}),
                    item(context, CupertinoIcons.creditcard, "Payment Method",
                        onPress: () {}),
                    item(context, CupertinoIcons.shopping_cart, "Order History",
                        onPress: () {}),
                    item(context, CupertinoIcons.location, "Address",
                        onPress: () {}),
                    item(context, CupertinoIcons.headphones, "Support Center",
                        onPress: () {}),
                    const SizedBox(height: 20),
                    EleButton(
                      name: "Logout",
                      onPressed: () => _showLogoutDialog(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget item(
      BuildContext context,
      IconData icon,
      String information, {
        required VoidCallback onPress,
      }) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1,),
          borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(10),
        onPressed: onPress,
        child: Row(
          children: [
            Icon(icon, color: CupertinoColors.systemGrey, size: 28),
            const SizedBox(width: 18),
            Text(
              information,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            const Icon(CupertinoIcons.chevron_forward, color: CupertinoColors.systemGrey),
          ],
        ),
      ),
    );
  }
}