import 'package:flutter/material.dart';
import 'package:fly/features/home/widget/home_bottomBar.dart';
import '../widget/home_body.dart';
import '../widget/home_header.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int selectedIndex = -1;
  String? searchQuery;
  void _onSearchChanged(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeHeader(onSearchChanged: _onSearchChanged),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: HomeBody()
      ),
      bottomNavigationBar: HomeBottomBar(),
    );
  }
}
