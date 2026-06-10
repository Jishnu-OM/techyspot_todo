import 'package:flutter/material.dart';
import 'package:techyspot_todo/core/themes/app_colors.dart';
import 'package:techyspot_todo/core/widgets/texts/normal_text.dart';

class CustomOutlinedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CustomOutlinedButton({
    super.key,
    required this.onTap, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 103,
      height: 44,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.white,

          side: const BorderSide(
            color: Color(0xFFE5E7EB),
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),

        child: NormalText(
          text: text,
          size: 12,
          weight: FontWeight.w500,
          color: AppColors.darkGrey,
        ),
      ),
    );
  }
}