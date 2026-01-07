import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fly/features/home/widget/home_body.dart';
import 'package:fly/features/home/widget/home_header.dart';
import 'package:provider/provider.dart';
import '../../../providers/product_provider.dart';
import '../../auth/provider/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
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
      final userProvider = context.read<UserProvider>();

      try {
        await Future.wait([
          productProvider.fetchProducts(),
          userProvider.fetchUser(),
        ]);
      } catch (e) {
        debugPrint('Error fetching data: $e');
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
                ? [
              CupertinoColors.black.withOpacity(0.95),
              CupertinoColors.black.withOpacity(0.98),
              CupertinoColors.black,
            ]
                : [
              CupertinoColors.systemBackground.withOpacity(0.95),
              CupertinoColors.systemBackground.withOpacity(0.98),
              CupertinoColors.systemBackground,
            ],
          ),
        ),
        child: SafeArea(
          child: loading
              ? Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    CupertinoColors.systemFill.resolveFrom(context).withOpacity(0.5),
                    CupertinoColors.secondarySystemFill.resolveFrom(context).withOpacity(0.3),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: CupertinoColors.separator.resolveFrom(context).withOpacity(0.2),
                  width: 0.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemBlue.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: const CupertinoActivityIndicator(
                radius: 16,
                color: CupertinoColors.systemBlue,
              ),
            ),
          )
              : Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1200, // perfect home max width
              ),
              child: HomeBody(
                selectedIndex: selectedIndex,
                searchQuery: searchQuery,
                onCategorySelected: _onCategorySelected,
                products: products,
                scrollController: _scrollController,
                provider: productProvider,
              ),
            ),
          ),
        ),
      ),
    );
  }
}