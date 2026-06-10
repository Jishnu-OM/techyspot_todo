import 'package:flutter/material.dart';
import 'package:techyspot_todo/core/themes/app_colors.dart';
import 'package:techyspot_todo/core/widgets/texts/normal_text.dart';

class SheetDropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;

  const SheetDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalText(
          text: label,
          size: 12,
          weight: FontWeight.w600,
          color: AppColors.darkGrey,
        ),

        const SizedBox(height: 8),

        DropdownButtonFormField<String>(
          value: value,
          items: items,
          onChanged: onChanged,

          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.darkGrey,
          ),

          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 11,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: AppColors.mischka,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: AppColors.primary,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}