import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/app_color.dart';
import '../../core/widgets/e_button.dart';

class FollowButtonExample extends StatefulWidget {
  const FollowButtonExample({super.key});

  @override
  State<FollowButtonExample> createState() => _FollowButtonExampleState();
}
class _FollowButtonExampleState extends State<FollowButtonExample> {
  bool isFollowing = false;

  void toggleFollow() {
    setState(() {
      isFollowing = !isFollowing;
    });
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: EButton(
        name: isFollowing ? "Unfollow" : "Follow",
        backgroundColor:
        isFollowing ? Colors.grey : AppColors.secondaryBlue,
        onPressed: toggleFollow,
      ),
    );
  }
}
