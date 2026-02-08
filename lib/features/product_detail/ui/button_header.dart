import 'package:flutter/material.dart';

class ButtonHeader extends StatefulWidget {
  final VoidCallback? onClickedBack;
  final VoidCallback? onClickedFavorite;
  final bool isFavorite;

  const ButtonHeader({
    super.key,
    this.onClickedBack,
    this.onClickedFavorite,
    this.isFavorite = false,
  });

  @override
  State<ButtonHeader> createState() => _ButtonHeaderState();
}

class _ButtonHeaderState extends State<ButtonHeader> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 50,
            bottom: 5,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back button
              Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade100, width: 1),
                ),
                child: IconButton(
                  alignment: Alignment.center,
                  onPressed: widget.onClickedBack,
                  icon: const Icon(Icons.arrow_back),
                ),
              ),

              // Favorite button
              Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade100, width: 1),
                ),
                child: IconButton(
                  onPressed: widget.onClickedFavorite,
                  icon: Icon(
                    widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: widget.isFavorite ? Colors.red : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
