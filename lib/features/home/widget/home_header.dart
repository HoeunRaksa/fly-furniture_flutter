import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fly/config/app_config.dart';
import 'package:fly/features/auth/provider/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../config/app_color.dart';

class HomeHeader extends StatefulWidget implements PreferredSizeWidget {
  const HomeHeader({super.key, required this.onSearchChanged});
  final void Function(String) onSearchChanged;

  @override
  State<HomeHeader> createState() => _HomeHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(115);
}

class _HomeHeaderState extends State<HomeHeader> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        widget.onSearchChanged("");
        _focusNode.unfocus();
      } else {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Container(
        color: Colors.white,
        child: SafeArea(
          bottom: false,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _isSearching ? _buildSearchingView() : _buildFurnitureHeader(user),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFurnitureHeader(user) {
    return Column(
      key: const ValueKey("furniture_header_view"),
      mainAxisSize: MainAxisSize.min,
      children: [
        // Row 1: Premium Furniture Brand Row
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
          child: Row(
            children: [
              Icon(Icons.menu),
              SizedBox(width: 10,),
              Text(
                "Batter_fly",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                  color: AppColors.furnitureBlue,
                  letterSpacing: -2.0,
                  height: 1.0,
                ),
              ),
              const Spacer(),
              _buildFurnitureIconButton(CupertinoIcons.add, onTap: () {}),
              const SizedBox(width: 10),
              _buildFurnitureIconButton(CupertinoIcons.search, onTap: _toggleSearch),
              const SizedBox(width: 10),
              _buildFurnitureIconButton(CupertinoIcons.bag_fill, onTap: () {}),
            ],
          ),
        ),
        
        // Row 2: Search/Status Bar Area
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => context.push("/profile"),
                child: CircleAvatar(
                  radius: 23,
                  backgroundColor: AppColors.secondary,
                  backgroundImage: user?.hasProfileImage == true
                      ? CachedNetworkImageProvider(user!.profileImageUrl!)
                      : const AssetImage("${AppConfig.imageUrl}/character.png") as ImageProvider,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: _toggleSearch,
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Search architectural pieces...",
                      style: TextStyle(
                        color: AppColors.bodyLine.withOpacity(0.6),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              const Icon(CupertinoIcons.slider_horizontal_3, color: AppColors.furnitureBlue, size: 24),
            ],
          ),
        ),
        
        const Divider(height: 1, thickness: 1, color: AppColors.divider),
      ],
    );
  }

  Widget _buildSearchingView() {
    return Column(
      key: const ValueKey("searching_furniture"),
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              IconButton(
                onPressed: _toggleSearch,
                icon: const Icon(CupertinoIcons.arrow_left, size: 24, color: AppColors.headerLine),
              ),
              Expanded(
                child: Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _focusNode,
                    autofocus: true,
                    onChanged: widget.onSearchChanged,
                    cursorColor: AppColors.furnitureBlue,
                    style: const TextStyle(fontSize: 16, color: AppColors.headerLine),
                    decoration: InputDecoration(
                      hintText: "Search our collection",
                      hintStyle: TextStyle(color: AppColors.bodyLine.withOpacity(0.5)),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      prefixIcon: Icon(CupertinoIcons.search, size: 18, color: AppColors.bodyLine.withOpacity(0.5)),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                widget.onSearchChanged("");
                                setState(() {});
                              },
                              child: Icon(CupertinoIcons.clear_fill, size: 18, color: AppColors.bodyLine.withOpacity(0.5)),
                            )
                          : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1, color: AppColors.divider),
        Container(height: 52, color: Colors.white), 
      ],
    );
  }

  Widget _buildFurnitureIconButton(IconData icon, {required VoidCallback onTap}) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.secondary,
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Icon(
              icon,
              size: 22,
              color: AppColors.headerLine,
            ),
          ),
        ),
      ),
    );
  }
}
