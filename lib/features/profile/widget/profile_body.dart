import 'package:flutter/material.dart';
import 'package:fly/core/widgets/elevated_button.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_color.dart';
import '../../../config/app_config.dart';
import '../../../model/user_auth.dart';

class ProfileBody extends StatelessWidget {
  final VoidCallback logout;
  final User user;

  const ProfileBody({super.key, required this.user, required this.logout});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are your sure you want to logout?"),
        actions: [
          EButton(name: "Cancel", onPressed: () => context.pop()),
          const SizedBox(height: 10),
          EButton(
            name: "Yes",
            onPressed: () {
              context.pop();
              logout();
              context.pushReplacement("/home");
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String capitalizeFirst(String? text) {
      if (text == null || text.isEmpty) return '';
      return text[0].toUpperCase() + text.substring(1);
    }

    final ImageProvider imageProvider =
    user.profileImage != null && user.profileImage!.isNotEmpty
        ? NetworkImage(AppConfig.getImageUrl(user.profileImage!))
        : const AssetImage("${AppConfig.imageUrl}/character.png");

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 140,
                  width: 140,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(70)),
                    child: Image(image: imageProvider),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  capitalizeFirst(user.name),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  "This this the extra information or bio",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    item(context, Icons.person, "Personal Information",
                        onPress: () {}),
                    item(context, Icons.payment, "Payment Method",
                        onPress: () {}),
                    item(context, Icons.shopping_cart, "Order History",
                        onPress: () {}),
                    item(context, Icons.pin_drop, "Address", onPress: () {}),
                    item(context, Icons.support_agent, "Support Center",
                        onPress: () {}),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () => _showLogoutDialog(context),
                      child: Text(
                        "Logout",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.red),
                      ),
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
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          spacing: 20,
          children: [
            Icon(icon, color: AppColors.gray500, size: 30),
            Text(
              information,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.w400),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
