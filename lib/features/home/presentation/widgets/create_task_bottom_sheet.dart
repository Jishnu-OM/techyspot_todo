import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:techyspot_todo/core/themes/app_colors.dart';
import 'package:techyspot_todo/core/widgets/buttons/custom_outlined_button.dart';
import 'package:techyspot_todo/core/widgets/buttons/primary_button.dart';
import 'package:techyspot_todo/core/widgets/inputs/custom_textbox.dart';
import 'package:techyspot_todo/core/widgets/texts/normal_text.dart';
import 'package:techyspot_todo/features/home/presentation/widgets/sheet_dropdown_field.dart';

class CreateTaskBottomSheet extends StatefulWidget {
  const CreateTaskBottomSheet({super.key});

  @override
  State<CreateTaskBottomSheet> createState() => _CreateTaskBottomSheetState();
}

class _CreateTaskBottomSheetState extends State<CreateTaskBottomSheet> {
  String selectedStatus = 'progress';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 12,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(24),
                ),
              ),

              const SizedBox(height: 24),

              const Align(
                alignment: Alignment.centerLeft,
                child: NormalText(
                  text: 'New task',
                  size: 16,
                  weight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 24),

              CustomTextbox(label: 'TITLE', hintText: "Enter the title..",),

              const SizedBox(height: 16),

              CustomTextbox(label: 'DESCRIPTION', hintText: "Enter the description...", maxLines: 2),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(child: CustomTextbox(label: 'START DATE', hintText: "eg: Jun 10, 2025",)),

                  const SizedBox(width: 12),

                  Expanded(child: CustomTextbox(label: 'END DATE', hintText: "eg: Jun 16, 2025",)),
                ],
              ),

              const SizedBox(height: 16),

              SheetDropdownField(
                label: 'STATUS',
                value: selectedStatus,

                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    selectedStatus = value;
                  });
                },

                items: const [
                  DropdownMenuItem(value: 'todo', child: Text('To do')),

                  DropdownMenuItem(
                    value: 'progress',
                    child: Text('In progress'),
                  ),

                  DropdownMenuItem(value: 'done', child: Text('Done')),
                ],
              ),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      text: "Cancel",
                      onTap: () => context.pop(context),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    flex: 2,
                    child: PrimaryButton(text: "Create task", onPressed: () {}),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
