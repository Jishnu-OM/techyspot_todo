import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techyspot_todo/core/constants/icon_constants.dart';
import 'package:techyspot_todo/core/themes/app_colors.dart';
import 'package:techyspot_todo/core/widgets/texts/normal_text.dart';

import 'status_chip.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String dateRange;
  final String status;
  final bool completed;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.dateRange,
    required this.status,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            offset: Offset(0, 1),
            blurRadius: 3,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          completed
              ? SvgPicture.asset(IconConstants.checked, width: 20, height: 21)
              : SvgPicture.asset(
                  IconConstants.notChecked,
                  width: 20,
                  height: 21,
                ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                NormalText(
                  text: title,
                  size: 14,
                  weight: FontWeight.w600,
                  color: completed ? AppColors.grey : AppColors.primary,
                  striked: completed,
                ),

                const SizedBox(height: 2),
                NormalText(
                  text: description,
                  size: 12,
                  weight: FontWeight.w400,
                  color: completed ? AppColors.mischka : AppColors.grey,
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    SvgPicture.asset(
                      IconConstants.calender,
                      height: 11,
                      width: 11,
                    ),

                    const SizedBox(width: 4),

                    NormalText(
                      text: dateRange,
                      size: 11,
                      weight: FontWeight.w400,
                      color: completed ? AppColors.mischka : AppColors.darkGrey,
                    ),

                    const SizedBox(width: 12),

                    StatusChip(text: status),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
