import 'package:flutter/material.dart';
import 'package:fly/features/home/widget/home_bottomBar.dart';
import 'package:provider/provider.dart';
import '../../../providers/product_provider.dart';
import '../widget/home_body.dart';
import '../widget/home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider = context.read<ProductProvider>();
      productProvider.fetchProducts();
    });
  }
  int selectedIndex = -1;
  String? searchQuery;

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
    final ProductProvider provider = context.watch<ProductProvider>();
    final products = provider.products;
    final loading = provider.loading;
    return Scaffold(
      appBar: HomeHeader(onSearchChanged: _onSearchChanged),
      body: loading ? const Center(child: CircularProgressIndicator(),) : HomeBody(
        selectedIndex: selectedIndex,
        searchQuery: searchQuery,
        onCategorySelected: _onCategorySelected,
        products: products,
      ),
      bottomNavigationBar: HomeBottomBar(),
    );
  }
}
