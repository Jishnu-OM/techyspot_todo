import 'package:flutter/material.dart';
import 'package:techyspot_todo/core/constants/icon_constants.dart';
import 'package:techyspot_todo/core/themes/app_colors.dart';
import 'package:techyspot_todo/core/widgets/texts/normal_text.dart';
import 'package:techyspot_todo/features/home/presentation/widgets/create_task_bottom_sheet.dart';

import '../widgets/task_card.dart';
import '../widgets/task_filter_chip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedFilter = 0;

  final filters = const ['All', 'To do', 'In progress', 'Done'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.white,
            barrierColor: Colors.black.withOpacity(0.4),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            builder: (context) {
              return const CreateTaskBottomSheet();
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

                            Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                color: AppColors.borderColor,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: const NormalText(
                                text: 'AJ',
                                size: 12,
                                weight: FontWeight.w600,
                                color: AppColors.darkGrey,
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

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: NormalText(
                            text: 'Tuesday, 4 tasks remaining',
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
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const NormalText(
                    text: 'TODAY',
                    size: 11,
                    weight: FontWeight.w600,
                    color: AppColors.grey,
                  ),

                  const SizedBox(height: 16),

                  const TaskCard(
                    title: 'Design system audit',
                    description:
                        'Review all components and flag inconsistencies across mobile screens.',
                    dateRange: 'Jun 9 → Jun 12',
                    status: 'In progress',
                    completed: false,
                  ),

                  const SizedBox(height: 12),

                  const TaskCard(
                    title: 'Write API docs',
                    description: 'Document all endpoints for the v2 release.',
                    dateRange: 'Jun 9 → Jun 14',
                    status: 'To do',
                    completed: false,
                  ),

                  const SizedBox(height: 24),

                  const NormalText(
                    text: 'EARLIER',
                    size: 11,
                    weight: FontWeight.w600,
                    color: AppColors.grey,
                  ),

                  const SizedBox(height: 16),

                  const TaskCard(
                    title: 'User interviews',
                    description: 'Conducted 5 sessions with beta testers.',
                    dateRange: 'Jun 2 → Jun 5',
                    status: 'Done',
                    completed: true,
                  ),

                  const SizedBox(height: 12),

                  const TaskCard(
                    title: 'Set up CI pipeline',
                    description:
                        'Configure GitHub Actions for automated testing and deployment.',
                    dateRange: 'Jun 7 → Jun 10',
                    status: 'To do',
                    completed: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
