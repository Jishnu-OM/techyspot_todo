import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techyspot_todo/core/themes/app_colors.dart';

class NormalText extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight weight;
  final Color? color;
  final bool alignCenter;
  final bool alignRight;
  final int? maxLines;
  final bool striked;
  const NormalText({
    super.key,
    required this.text,
    this.size = 12,
    this.weight = FontWeight.w500,
    this.color,
    this.alignCenter = false,
    this.maxLines,
    this.alignRight = false,
    this.striked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign:
          alignCenter
              ? TextAlign.center
              : alignRight
              ? TextAlign.end
              : null,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      
      style: getNormalTextStyle(
        size: size,
        weight: weight,
        color: color,
        isStriked: striked,
      ),
    );
  }
}

TextStyle getNormalTextStyle({
  double size = 12,
  FontWeight weight = FontWeight.w400,
  Color? color,
  double? letterSpacing,
  bool isStriked = false,
}) {
  return GoogleFonts.inter(
    textStyle: TextStyle(
      letterSpacing: letterSpacing,
      fontSize: size,
      fontWeight: weight,
      height: 1.518,
      color: color,
      decoration: isStriked ? TextDecoration.lineThrough : null,
      decorationColor: AppColors.grey
    ),
  );
}
