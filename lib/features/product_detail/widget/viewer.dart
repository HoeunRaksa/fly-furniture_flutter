import 'package:flutter/material.dart';
import 'package:fly/config/app_color.dart';

class Viewer extends StatelessWidget {
  final int view;
  final int like;
  final int rating;
  final maxStart = 5;
  final Function(int)? onRatingChanged;
  const Viewer({
    super.key,
    this.view = 0,
    this.like = 0,
    this.onRatingChanged,
    this.rating = 0,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.people, color: AppColors.mediumGrey.withAlpha(190)),
                  SizedBox(width: 5),
                  Text(
                    "${view.toString()} seen",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(width: 20),
                  Icon(
                    Icons.favorite_border,
                    color: AppColors.mediumGrey.withAlpha(190),
                  ),
                  SizedBox(width: 5),
                  Text(
                    like.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Row(
              children: List.generate(maxStart, (index) {
                return IconButton(
                  onPressed: () => onRatingChanged!(index + 1),
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.orangeAccent,
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }
}
