import 'package:flutter/material.dart';
import '../../../core/widgets/product_card.dart';
import '../../../core/widgets/small_card.dart';
import 'category.dart';
import 'home_section_scroller.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});
  @override
  State<HomeBody> createState() => _HomeBody();
}

class _HomeBody extends State<HomeBody> {
  int selectedIndex = -1;
  String? searchQuery;
  void _onSearchChanged(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 2,
        children: [
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Special Offers",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: 10),
          HomeSectionScroller(),
          SizedBox(height: 30),
          SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Category(
                  index: index,
                  selectedIndex: selectedIndex,
                  onTap: () {
                    setState(() {
                      selectedIndex = selectedIndex == index ? -1 : index;
                    });
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 7),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Most Interested",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "View",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.orangeAccent,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),

          Container(
            height: 250,
            alignment: Alignment.topCenter,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 30,
              itemBuilder: (context, index) => SizedBox(
                height: 200,
                child: ProductCard(
                  image: 'character.png',
                  name: "The Sunflower",
                  description: "This is the best flower in the world",
                  price: 200,
                  setIcon: true,
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(width: 10),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Popular", style: Theme.of(context).textTheme.headlineSmall),
              TextButton(
                onPressed: () {},
                child: Text(
                  "View",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.orangeAccent,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 5),
          Container(
            height: 100,
            alignment: Alignment.center,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (context, index) => SizedBox(
                height: 100,
                child: SmallCard(
                  name: "Iphone",
                  description: "This is a good one",
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(width: 10),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
