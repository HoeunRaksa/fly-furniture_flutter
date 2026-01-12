import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly/features/home/widget/home_body.dart';
import 'package:fly/features/home/widget/home_header.dart';
import 'package:provider/provider.dart';
import '../../../providers/product_provider.dart';
import '../../../model/product.dart';
import '../../auth/provider/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
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
    final products = productProvider.products;
    final loading = productProvider.loading;
    final error = productProvider.error;

    final brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: CupertinoTheme.of(context).scaffoldBackgroundColor,
      appBar: HomeHeader(onSearchChanged: _onSearchChanged),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? const [
              Color.fromRGBO(0, 0, 0, 0.95),
              Color.fromRGBO(0, 0, 0, 0.98),
              Color(0xFF000000),
            ]
                : const [
              Color.fromRGBO(255, 255, 255, 0.95),
              Color.fromRGBO(255, 255, 255, 0.98),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: SafeArea(
          child: _buildBody(
            loading,
            error,
            products,
            productProvider,
            isDark,
            context,
          ),
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
      ) {
    // Loading state
    if (loading && products.isEmpty) {
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? const [
                    Color.fromRGBO(255, 255, 255, 0.08),
                    Color.fromRGBO(255, 255, 255, 0.04),
                  ]
                      : const [
                    Color.fromRGBO(255, 255, 255, 0.5),
                    Color.fromRGBO(255, 255, 255, 0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? const Color.fromRGBO(255, 255, 255, 0.15)
                      : const Color.fromRGBO(255, 255, 255, 0.4),
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 122, 255, 0.1),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoActivityIndicator(
                    radius: 16,
                    color: CupertinoColors.systemBlue,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Loading products...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Error state
    if (error != null && products.isEmpty) {
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(255, 59, 48, 0.15),
                    Color.fromRGBO(255, 59, 48, 0.08),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color.fromRGBO(255, 59, 48, 0.4),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    CupertinoIcons.exclamationmark_triangle,
                    size: 48,
                    color: CupertinoColors.destructiveRed,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error Loading Products',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
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
            ),
          ),
        ),
      );
    }

    // Empty state
    if (products.isEmpty && !loading) {
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? const [
                    Color.fromRGBO(255, 255, 255, 0.08),
                    Color.fromRGBO(255, 255, 255, 0.04),
                  ]
                      : const [
                    Color.fromRGBO(255, 255, 255, 0.5),
                    Color.fromRGBO(255, 255, 255, 0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark
                      ? const Color.fromRGBO(255, 255, 255, 0.15)
                      : const Color.fromRGBO(255, 255, 255, 0.4),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    CupertinoIcons.cube_box,
                    size: 64,
                    color: CupertinoColors.systemGrey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Products Found',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Check back later for new arrivals',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  CupertinoButton.filled(
                    onPressed: () {
                      provider.fetchProducts(forceRefresh: true);
                    },
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Success state - show products
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: HomeBody(
          selectedIndex: selectedIndex,
          searchQuery: searchQuery,
          onCategorySelected: _onCategorySelected,
          products: products,
          scrollController: _scrollController,
          provider: provider,
        ),
      ),
    );
  }
}