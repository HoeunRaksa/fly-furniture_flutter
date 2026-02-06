import 'package:flutter/cupertino.dart';

class FavoriteBody extends StatelessWidget {
  const FavoriteBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (_,index) => Container(child: Text("No Items"),));
  }
}
