import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techyspot_todo/core/constants/icon_constants.dart';
import 'package:techyspot_todo/core/themes/app_colors.dart';
import 'package:techyspot_todo/core/widgets/texts/normal_text.dart';

class GoogleSigninButton extends StatelessWidget {
  final VoidCallback onPressed;
  const GoogleSigninButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: OutlinedButton(
        onPressed: onPressed,

        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(color: AppColors.borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(IconConstants.google, height: 16, width: 16),
            SizedBox(width: 8),
            NormalText(
              text: "Continue with Google",
              size: 13,
              weight: FontWeight.w500,
              color: AppColors.oxfordBlue,
            ),
          ],
        ),
      ),
    );
  }
}
