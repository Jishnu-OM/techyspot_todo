import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:techyspot_todo/core/constants/icon_constants.dart';
import 'package:techyspot_todo/core/helpers/task_helper.dart';
import 'package:techyspot_todo/core/router/route_names.dart';
import 'package:techyspot_todo/core/themes/app_colors.dart';
import 'package:techyspot_todo/core/widgets/texts/normal_text.dart';
import 'package:techyspot_todo/features/home/presentation/providers/home_provider.dart';
import 'package:techyspot_todo/features/home/presentation/widgets/create_task_bottom_sheet.dart';
import 'package:techyspot_todo/features/home/presentation/widgets/delete_task_dialog.dart';

import '../widgets/task_card.dart';
import '../widgets/task_filter_chip.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int selectedFilter = 0;

  final filters = const ['All', 'To do', 'In progress', 'Done'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);

    final dayName = TaskHelper.getDayName();

    final filteredTasks = TaskHelper.filterTasks(
      homeState.task,
      selectedFilter,
    );

    final todayTasks = TaskHelper.getTodayTasks(filteredTasks);

    final earlierTasks = TaskHelper.getEarlierTasks(filteredTasks);

    final hasTasks = todayTasks.isNotEmpty || earlierTasks.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: AppColors.white,
            barrierColor: Colors.black.withOpacity(0.4),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            builder: (context) {
              return CreateTaskBottomSheet();
            },
          );
        },
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.28),
                offset: const Offset(0, 4),
                blurRadius: 16,
              ),
            ],
          ),
          child: const Icon(Icons.add, color: AppColors.white),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(IconConstants.logo, height: 19),
                            const SizedBox(width: 8),
                            const NormalText(
                              text: 'TechySpot',
                              size: 14,
                              weight: FontWeight.w700,
                              color: AppColors.primary,
                            ),

                            const Spacer(),

                            GestureDetector(
                              onTap: () {
                                context.push(RouteNames.logout);
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  color: AppColors.borderColor,
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: NormalText(
                                  text: homeState.user == null
                                      ? 'TS'
                                      : homeState.user!
                                            .substring(0, 2)
                                            .toUpperCase(),
                                  size: 12,
                                  weight: FontWeight.w600,
                                  color: AppColors.darkGrey,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 18),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: NormalText(
                            text: 'My Tasks',
                            size: 18,
                            weight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: NormalText(
                            text:
                                '$dayName, ${homeState.task.length} tasks remaining', //'Tuesday, 4 tasks remaining'
                            size: 12,
                            weight: FontWeight.w400,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(color: AppColors.athensGray),
                        bottom: BorderSide(color: AppColors.athensGray),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(22, 12, 22, 12),
                      child: SizedBox(
                        height: 27,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: filters.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            return TaskFilterChip(
                              title: filters[index],
                              selected: selectedFilter == index,
                              onTap: () {
                                setState(() {
                                  selectedFilter = index;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: homeState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : homeState.task.isEmpty
                  ? const Center(child: NormalText(text: 'No Tasks Found'))
                  : !hasTasks
                  ? const Center(child: NormalText(text: 'No Tasks Found'))
                  : ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        if (todayTasks.isNotEmpty) ...[
                          const NormalText(
                            text: 'TODAY',
                            size: 11,
                            weight: FontWeight.w600,
                            color: AppColors.grey,
                          ),

                          const SizedBox(height: 16),

                          ...todayTasks.map(
                            (task) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: AppColors.white,
                                    barrierColor: Colors.black.withOpacity(0.4),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(28),
                                      ),
                                    ),
                                    builder: (_) {
                                      return CreateTaskBottomSheet(
                                        isEdit: true,
                                        task: task,
                                      );
                                    },
                                  );
                                },
                                child: TaskCard(
                                  title: task.title,
                                  description: task.description,
                                  dateRange:
                                      '${task.startDate != null ? DateFormat('MMM d').format(task.startDate!) : 'N/A'} → ${task.endDate != null ? DateFormat('MMM d').format(task.endDate!) : 'N/A'}',
                                  status: task.status,
                                  completed:
                                      task.status.toLowerCase() == 'done',
                                  onToggleComplete: () async {
                                    await ref
                                        .read(homeProvider.notifier)
                                        .updateTaskStatus(task);
                                  },
                                  onDelete: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return DeleteTaskDialog(
                                          onConfirm: () async {
                                            await ref
                                                .read(homeProvider.notifier)
                                                .deleteTask(task.id);

                                            if (context.mounted) {
                                              context.pop();
                                            }
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],

                        if (earlierTasks.isNotEmpty) ...[
                          const SizedBox(height: 24),

                          const NormalText(
                            text: 'EARLIER',
                            size: 11,
                            weight: FontWeight.w600,
                            color: AppColors.grey,
                          ),

                          const SizedBox(height: 16),

                          ...earlierTasks.map(
                            (task) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: AppColors.white,
                                    barrierColor: Colors.black.withOpacity(0.4),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(28),
                                      ),
                                    ),
                                    builder: (_) {
                                      return CreateTaskBottomSheet(
                                        isEdit: true,
                                        task: task,
                                      );
                                    },
                                  );
                                },
                                child: TaskCard(
                                  title: task.title,
                                  description: task.description,
                                  dateRange:
                                      '${task.startDate != null ? DateFormat('MMM d').format(task.startDate!) : 'N/A'} → ${task.endDate != null ? DateFormat('MMM d').format(task.endDate!) : 'N/A'}',
                                  status: task.status,
                                  completed:
                                      task.status.toLowerCase() == 'done',
                                  onToggleComplete: () async {
                                    await ref
                                        .read(homeProvider.notifier)
                                        .updateTaskStatus(task);
                                  },

                                  onDelete: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return DeleteTaskDialog(
                                          onConfirm: () async {
                                            await ref
                                                .read(homeProvider.notifier)
                                                .deleteTask(task.id);

                                            if (context.mounted) {
                                              context.pop();
                                            }
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
