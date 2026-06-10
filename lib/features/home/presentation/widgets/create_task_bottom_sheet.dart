import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:techyspot_todo/core/themes/app_colors.dart';
import 'package:techyspot_todo/core/widgets/buttons/custom_outlined_button.dart';
import 'package:techyspot_todo/core/widgets/buttons/primary_button.dart';
import 'package:techyspot_todo/core/widgets/inputs/custom_textbox.dart';
import 'package:techyspot_todo/core/widgets/texts/normal_text.dart';
import 'package:techyspot_todo/features/home/domain/entites/task_entity.dart';
import 'package:techyspot_todo/features/home/presentation/providers/home_provider.dart';
import 'package:techyspot_todo/features/home/presentation/widgets/sheet_dropdown_field.dart';

class CreateTaskBottomSheet extends ConsumerStatefulWidget {
  final bool isEdit;
  final TaskEntity? task;
  const CreateTaskBottomSheet({super.key, this.isEdit = false, this.task});

  @override
  ConsumerState<CreateTaskBottomSheet> createState() =>
      _CreateTaskBottomSheetState();
}

class _CreateTaskBottomSheetState extends ConsumerState<CreateTaskBottomSheet> {
  String selectedStatus = 'todo';
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.isEdit && widget.task != null) {
      titleController.text = widget.task!.title;

      descriptionController.text = widget.task!.description;

      startDateController.text = DateFormat(
        'MMM dd, yyyy',
      ).format(widget.task!.startDate!);

      endDateController.text = DateFormat(
        'MMM dd, yyyy',
      ).format(widget.task!.endDate!);

      selectedStatus = widget.task!.status;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );

    if (selectedDate == null) return;

    controller.text = DateFormat(
      'MMM dd, yyyy',
    ).format(selectedDate);
  }

  String? requiredValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Required';
    }

    return null;
  }

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
          child: Form(
            key: _formKey,
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

                Align(
                  alignment: Alignment.centerLeft,
                  child: NormalText(
                    text: widget.isEdit ? 'Edit task' : 'New task',
                    size: 16,
                    weight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),

                const SizedBox(height: 24),

                CustomTextbox(
                  label: 'TITLE',
                  hintText: "Enter the title..",
                  controller: titleController,
                  validator: requiredValidator,
                ),

                const SizedBox(height: 16),

                CustomTextbox(
                  label: 'DESCRIPTION',
                  hintText: "Enter the description...",
                  maxLines: 2,
                  controller: descriptionController,
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _pickDate(startDateController),
                        child: AbsorbPointer(
                          child: CustomTextbox(
                            controller: startDateController,
                            label: 'START DATE',
                            hintText: 'Select date',
                            validator: requiredValidator,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: GestureDetector(
                        onTap: () => _pickDate(endDateController),
                        child: AbsorbPointer(
                          child: CustomTextbox(
                            controller: endDateController,
                            label: 'END DATE',
                            hintText: 'Select date',
                            validator: requiredValidator,
                          ),
                        ),
                      ),
                    ),
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
                      child: PrimaryButton(
                        text: widget.isEdit ? 'Update task' : 'Create task',
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          final task = TaskEntity(
                            id: widget.task?.id ?? '',
                            title: titleController.text.trim(),
                            description: descriptionController.text.trim(),
                            status: selectedStatus,

                            startDate: DateFormat(
                              'MMM dd, yyyy',
                            ).parse(startDateController.text),

                            endDate: DateFormat(
                              'MMM dd, yyyy',
                            ).parse(endDateController.text),

                            createdAt: widget.task?.createdAt ?? DateTime.now(),
                          );

                          if (widget.isEdit) {
                            await ref
                                .read(homeProvider.notifier)
                                .updateTask(task);
                          } else {
                            await ref
                                .read(homeProvider.notifier)
                                .createTask(task);
                          }

                          if (mounted) {
                            context.pop();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
