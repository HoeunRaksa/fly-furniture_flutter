import 'dart:ui';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/app_color.dart';
import '../../auth/provider/auth_provider.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  // Image Picker Function
  Future<void> _pickImage(ImageSource source, AuthProvider authProvider) async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 85, // Reduce file size
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (pickedFile == null) return;

      final imageFile = File(pickedFile.path);

      // Show loading dialog
      if (!mounted) return;
      showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: CupertinoColors.systemBackground.resolveFrom(context),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoActivityIndicator(radius: 16),
                  SizedBox(height: 16),
                  Text('Uploading image...', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        ),
      );

      // Upload the image
      await authProvider.updateProfile(profileImage: imageFile);

      if (mounted) {
        Navigator.of(context).pop(); // Close loading dialog

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(
                  CupertinoIcons.check_mark_circled_solid,
                  color: Colors.white,
                ),
                SizedBox(width: 12),
                Text('Profile image updated successfully'),
              ],
            ),
            backgroundColor: CupertinoColors.systemGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint('Image upload error: $e');

      if (mounted) {
        // Close loading dialog if still open
        try {
          Navigator.of(context).pop();
        } catch (_) {}

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                Expanded(child: Text('Upload failed: ${e.toString()}')),
              ],
            ),
            backgroundColor: CupertinoColors.destructiveRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  // Delete Profile Image Function
  Future<void> _deleteProfileImage(AuthProvider authProvider) async {
    if (!mounted) return;

    // Show loading dialog
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: CupertinoColors.systemBackground.resolveFrom(context),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoActivityIndicator(radius: 16),
                SizedBox(height: 16),
                Text('Removing image...', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      await authProvider.deleteProfileImage();

      if (mounted) {
        Navigator.of(context).pop(); // Close loading dialog

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(
                  CupertinoIcons.check_mark_circled_solid,
                  color: Colors.white,
                ),
                SizedBox(width: 12),
                Text('Profile picture removed'),
              ],
            ),
            backgroundColor: CupertinoColors.systemGreen,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // Close loading dialog

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(
                  CupertinoIcons.xmark_circle_fill,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                Expanded(child: Text('Failed to remove: ${e.toString()}')),
              ],
            ),
            backgroundColor: CupertinoColors.destructiveRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    }
  }

  // Logout Function
  void _showLogoutDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: CupertinoAlertDialog(
          title: const Text(
            "Logout",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            CupertinoDialogAction(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text("Logout"),
              onPressed: () async {
                // Close confirmation dialog first
                Navigator.of(context).pop();

                final authProvider = context.read<AuthProvider>();
                final navigator = Navigator.of(context);
                final scaffoldMessenger = ScaffoldMessenger.of(context);

                // Show loading
                showCupertinoDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemBackground.resolveFrom(
                            context,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CupertinoActivityIndicator(radius: 16),
                            SizedBox(height: 16),
                            Text('Logging out...'),
                          ],
                        ),
                      ),
                    ),
                  ),
                );

                try {
                  await authProvider.logout();

                  // Close loading dialog
                  if (context.mounted) {
                    navigator.pop();
                  }

                  // Navigate to home - use a slight delay to ensure dialog is closed
                  await Future.delayed(const Duration(milliseconds: 100));

                  if (context.mounted) {
                    context.go("/home");
                  }
                } catch (e) {
                  debugPrint('Logout error: $e');

                  // Close loading dialog
                  if (context.mounted) {
                    try {
                      navigator.pop();
                    } catch (_) {
                      // Dialog already closed
                    }

                    scaffoldMessenger.showSnackBar(
                      SnackBar(
                        content: Text('Logout failed: ${e.toString()}'),
                        backgroundColor: CupertinoColors.destructiveRed,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    if (user == null) {
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ]
                      : [
                          Colors.white.withOpacity(0.9),
                          Colors.white.withOpacity(0.7),
                        ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.15)
                      : Colors.white.withOpacity(0.5),
                  width: 1.5,
                ),
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoActivityIndicator(),
                  SizedBox(height: 16),
                  Text('Loading profile...'),
                ],
              ),
            ),
          ),
        ),
      );
    }

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
                const SizedBox(height: 10),

                // Profile Image with Glass Effect
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildProfileImage(
                      context,
                      user,
                      authProvider,
                      isDark,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // User Info with Glass Card
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildUserInfoCard(context, user, isDark),
                ),

                const SizedBox(height: 20),

                // Menu Items
                _buildMenuItems(context, isDark),

                const SizedBox(height: 20),

                // Logout Button
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildLogoutButton(context, isDark),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(
    BuildContext context,
    dynamic user,
    AuthProvider authProvider,
    bool isDark,
  ) {
    return Stack(
      children: [
        // Glass Container for profile image
        ClipRRect(
          borderRadius: BorderRadius.circular(70),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          Colors.white.withOpacity(0.15),
                          Colors.white.withOpacity(0.08),
                        ]
                      : [
                          Colors.white.withOpacity(0.9),
                          Colors.white.withOpacity(0.7),
                        ],
                ),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.2)
                      : Colors.white.withOpacity(0.6),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondaryGreen.withOpacity(0.2),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withOpacity(0.4)
                        : Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(65),
                  child: user.hasProfileImage
                      ? CachedNetworkImage(
                          imageUrl: user.profileImageUrl!,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.secondaryGreen.withOpacity(0.3),
                                  AppColors.greenLight.withOpacity(0.2),
                                ],
                              ),
                            ),
                            child: const Center(
                              child: CupertinoActivityIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  CupertinoColors.systemGrey5,
                                  CupertinoColors.systemGrey6,
                                ],
                              ),
                            ),
                            child: const Icon(
                              CupertinoIcons.person_fill,
                              size: 60,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.secondaryGreen.withOpacity(0.2),
                                AppColors.greenLight.withOpacity(0.1),
                              ],
                            ),
                          ),
                          child: const Icon(
                            CupertinoIcons.person_fill,
                            size: 60,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),

        // Camera Button with Glass Effect
        Positioned(
          bottom: 5,
          right: 5,
          child: GestureDetector(
            onTap: () => _showImagePickerDialog(context, authProvider, isDark),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.secondaryGreen, AppColors.greenDark],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondaryGreen.withOpacity(0.5),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    CupertinoIcons.camera_fill,
                    size: 22,
                    color: CupertinoColors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfoCard(BuildContext context, dynamic user, bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.05),
                    ]
                  : [
                      Colors.white.withOpacity(0.9),
                      Colors.white.withOpacity(0.7),
                    ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.15)
                  : Colors.white.withOpacity(0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                _capitalizeFirst(user.name),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                user.email,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: CupertinoColors.secondaryLabel.resolveFrom(context),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Role Badge with Glass Effect
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: user.role == 'admin'
                            ? [
                                CupertinoColors.systemPurple.withOpacity(0.3),
                                CupertinoColors.systemPurple.withOpacity(0.2),
                              ]
                            : [
                                AppColors.secondaryGreen.withOpacity(0.3),
                                AppColors.greenLight.withOpacity(0.2),
                              ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: user.role == 'admin'
                            ? CupertinoColors.systemPurple.withOpacity(0.5)
                            : AppColors.secondaryGreen.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          user.role == 'admin'
                              ? CupertinoIcons.star_fill
                              : CupertinoIcons.person_fill,
                          color: user.role == 'admin'
                              ? CupertinoColors.systemPurple
                              : AppColors.secondaryGreen,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          user.role.toUpperCase(),
                          style: TextStyle(
                            color: user.role == 'admin'
                                ? CupertinoColors.systemPurple
                                : AppColors.secondaryGreen,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItems(BuildContext context, bool isDark) {
    final menuItems = [
      {
        'icon': CupertinoIcons.person,
        'title': 'Personal Information',
        'onTap': () => context.push('/edit-profile'),
      },
      {
        'icon': CupertinoIcons.creditcard,
        'title': 'Payment Method',
        'onTap': () => _showComingSoon(context, 'Payment Method'),
      },
      {
        'icon': CupertinoIcons.shopping_cart,
        'title': 'Order History',
        'onTap': () => _showComingSoon(context, 'Order History'),
      },
      {
        'icon': CupertinoIcons.location,
        'title': 'Address',
        'onTap': () => _showComingSoon(context, 'Address'),
      },
      {
        'icon': CupertinoIcons.settings,
        'title': 'Settings',
        'onTap': () => _showComingSoon(context, 'Settings'),
      },
      {
        'icon': CupertinoIcons.headphones,
        'title': 'Support Center',
        'onTap': () => _showComingSoon(context, 'Support Center'),
      },
    ];

    return Column(
      children: menuItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;

        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 400 + (index * 80)),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(30 * (1 - value), 0),
              child: Opacity(
                opacity: value,
                child: _buildMenuItem(
                  context,
                  item['icon'] as IconData,
                  item['title'] as String,
                  item['onTap'] as VoidCallback,
                  isDark,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
    bool isDark,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.05),
                      ]
                    : [
                        Colors.white.withOpacity(0.9),
                        Colors.white.withOpacity(0.7),
                      ],
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.15)
                    : Colors.white.withOpacity(0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withOpacity(0.2)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              borderRadius: BorderRadius.circular(18),
              onPressed: onTap,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.secondaryGreen.withOpacity(0.2),
                          AppColors.greenLight.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      icon,
                      color: AppColors.secondaryGreen,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  Icon(
                    CupertinoIcons.chevron_forward,
                    color: CupertinoColors.secondaryLabel.resolveFrom(context),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [CupertinoColors.destructiveRed, Color(0xFFFF3B30)],
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: CupertinoColors.destructiveRed.withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: CupertinoButton(
            padding: const EdgeInsets.symmetric(vertical: 14),
            borderRadius: BorderRadius.circular(18),
            onPressed: () => _showLogoutDialog(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.arrow_right_square,
                  color: Colors.white,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Text(
                  "Logout",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showImagePickerDialog(
    BuildContext context,
    AuthProvider authProvider,
    bool isDark,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: CupertinoActionSheet(
          title: const Text(
            'Change Profile Picture',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera, authProvider);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.camera,
                    color: CupertinoColors.activeBlue,
                  ),
                  SizedBox(width: 12),
                  Text('Take Photo', style: TextStyle(fontSize: 17)),
                ],
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery, authProvider);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.photo, color: CupertinoColors.activeBlue),
                  SizedBox(width: 12),
                  Text('Choose from Gallery', style: TextStyle(fontSize: 17)),
                ],
              ),
            ),
            if (authProvider.user?.hasProfileImage == true)
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                  _deleteProfileImage(authProvider);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.delete),
                    SizedBox(width: 12),
                    Text('Remove Photo', style: TextStyle(fontSize: 17)),
                  ],
                ),
              ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    showCupertinoDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: CupertinoAlertDialog(
          title: Text(feature),
          content: const Text('This feature is coming soon!'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  String _capitalizeFirst(String? text) {
    if (text == null || text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }
}
