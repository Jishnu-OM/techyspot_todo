import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../core/widgets/buttons/custom_outlined_button.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/texts/normal_text.dart';

class DeleteTaskDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeleteTaskDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const NormalText(
              text: 'Delete Task',
              size: 18,
              weight: FontWeight.w700,
            ),

            const SizedBox(height: 12),

            const NormalText(
              text: 'Are you sure you want to delete this task?',
              size: 14,
              color: AppColors.darkGrey,
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    text: 'Cancel',
                    onTap: () {
                      context.pop();
                    },
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: PrimaryButton(text: 'Delete', onPressed: onConfirm),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
