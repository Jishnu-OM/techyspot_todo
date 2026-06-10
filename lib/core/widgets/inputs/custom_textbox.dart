import 'package:flutter/material.dart';
import 'package:techyspot_todo/core/themes/app_colors.dart';
import 'package:techyspot_todo/core/widgets/texts/normal_text.dart';

class CustomTextbox extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final int maxLines;
  final String? Function(String?)? validator;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomTextbox({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.maxLines = 1,
    this.validator,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalText(
          text: label,
          size: 11,
          weight: FontWeight.w600,
          color: AppColors.darkGrey,
        ),
        const SizedBox(height: 2,),

        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,

          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 12,
              color: AppColors.grey,
            ),
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