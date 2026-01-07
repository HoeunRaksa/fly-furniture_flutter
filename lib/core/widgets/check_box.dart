import 'package:flutter/material.dart';
import 'package:fly/config/app_color.dart';

class CheckBoxed extends StatelessWidget {
  const CheckBoxed({
    super.key,
    required this.value,
    required this.valueChanged,
    this.label = "",
  });
  final bool value;
  final ValueChanged<bool?> valueChanged;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: value,
          onChanged: valueChanged,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          side: BorderSide(width: 1, color: Colors.grey),
        ),

        if (label.isNotEmpty)
          Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.mediumGrey.withAlpha(160)
          )),
      ],
    );
  }
}
