import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly/core/widgets/input_field.dart';
import 'package:fly/features/home/widget/home_body.dart';
import 'package:fly/features/home/widget/home_header.dart';
import 'package:fly/model/user_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../config/app_color.dart';
import '../../../config/app_config.dart';
import '../../../providers/product_provider.dart';
import '../../../model/product.dart';
import '../../auth/provider/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _animationController;
  int selectedIndex = -1;
  String? searchQuery;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final productProvider = context.read<ProductProvider>();
      final authProvider = context.read<AuthProvider>();

      try {
        await Future.wait([
          productProvider.fetchProducts(),
          authProvider.fetchUser(),
        ]);
        debugPrint('✅ Products loaded: ${productProvider.products.length}');
      } catch (e) {
        debugPrint('❌ Error fetching data: $e');
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (!mounted) return;
    setState(() {
      searchQuery = value;
    });
  }

  void _onCategorySelected(int index) {
    if (!mounted) return;
    setState(() {
      selectedIndex = selectedIndex == index ? -1 : index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final authProvider = context.watch<AuthProvider>();
    final users = authProvider.user;
    final products = productProvider.products;
    final loading = productProvider.loading;
    final error = productProvider.error;
    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.primary,
      body: Container(
        decoration: BoxDecoration(color: AppColors.primary),
        child: _buildBody(
          loading,
          error,
          products,
          productProvider,
          isDark,
          context,
          users,
        ),
      ),
    );
  }

  Widget _buildBody(
    bool loading,
    String? error,
    List<Product> products,
    ProductProvider provider,
    bool isDark,
    BuildContext context,
    User? users,
  ) {
    if (loading && products.isEmpty) {
      return const Center(child: CupertinoActivityIndicator(radius: 16));
    }

    if (error != null && products.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              CupertinoIcons.exclamationmark_triangle,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Error Loading Products',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            CupertinoButton.filled(
              onPressed: () {
                provider.clearError();
                provider.fetchProducts(forceRefresh: true);
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    final String profileUrl = (users?.profileImageUrl ?? '').toString().trim();
    final bool isSelect = false;
    return Column(
      children: [
        HomeHeader(onSearchChanged: _onSearchChanged),
        // User Profile Section - 100% width, no overflow
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            children: [
             InkWell(
               child: CircleAvatar(
                 radius: 22,
                 backgroundColor: Colors.grey.shade200,
                 child: ClipOval(
                   child: CachedNetworkImage(
                     imageUrl: AppConfig.getImageUrl(profileUrl),
                     width: 44,
                     height: 44,
                     fit: BoxFit.cover,
                     placeholder: (context, url) => const Center(
                       child: CircularProgressIndicator(strokeWidth: 2),
                     ),
                     errorWidget: (context, url, error) =>
                     const Icon(Icons.broken_image),
                   ),
                 ),
               ),
               onTap: () {
                 context.push('/profile');
               },
             ),
              const SizedBox(width: 15), // Replaced spacing for compatibility
              const Expanded(
                child: Text(
                  "You will find the best for you!",
                  style: TextStyle(fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1, color: AppColors.divider),
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: HomeBody(
              selectedIndex: selectedIndex,
              searchQuery: searchQuery,
              onCategorySelected: _onCategorySelected,
              products: products,
              scrollController: _scrollController,
              provider: provider,
              isSelect: isSelect,
            ),
          ),
        ),
      ],
    );
  }
}
