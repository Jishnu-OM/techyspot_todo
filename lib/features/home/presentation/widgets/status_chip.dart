import 'package:flutter/material.dart';
import 'package:techyspot_todo/core/widgets/texts/normal_text.dart';

class StatusChip extends StatelessWidget {
  final String text;

  const StatusChip({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (text.toLowerCase()) {
      case 'in progress':
        backgroundColor = const Color(0xFFE0E7FF);
        textColor = const Color(0xFF4338CA);
        break;

      case 'done':
        backgroundColor = const Color(0xFFD1FAE5);
        textColor = const Color(0xFF047857);
        break;

      default:
        backgroundColor = const Color(0xFFFEF3C7);
        textColor = const Color(0xFFB45309);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: NormalText(
        text: text,
        size: 10,
        weight: FontWeight.w600,
        color: textColor,
      ),
    );
  }
}