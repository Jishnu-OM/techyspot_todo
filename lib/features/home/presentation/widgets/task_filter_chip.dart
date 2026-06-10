import 'package:flutter/material.dart';
import 'package:techyspot_todo/core/themes/app_colors.dart';
import 'package:techyspot_todo/core/widgets/texts/normal_text.dart';

class TaskFilterChip extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const TaskFilterChip({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 5
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary
              : AppColors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
              ? AppColors.primary
              : AppColors.athensGray,
          ),
        ),
        alignment: Alignment.center,
        child: NormalText(
          text:  title,
          size: 12,
          weight: FontWeight.w500,
          color: selected
              ? AppColors.white
              : AppColors.darkGrey,
        ),
      ),
    );
  }
}