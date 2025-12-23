import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/core/widgets/space_card.dart';
import 'package:uimspace_app/core/widgets/space_components.dart';

/// Model untuk data tugas mendatang
class UpcomingTask {
  final String id;
  final String title;
  final String courseName;
  final DateTime dueDate;
  final TaskPriority priority;
  final TaskType type;

  const UpcomingTask({
    required this.id,
    required this.title,
    required this.courseName,
    required this.dueDate,
    this.priority = TaskPriority.normal,
    this.type = TaskType.assignment,
  });
}

enum TaskPriority { low, normal, high, urgent }

enum TaskType { assignment, quiz, project, exam }

/// Widget untuk menampilkan daftar tugas yang akan datang
class UpcomingTasksSection extends StatelessWidget {
  final List<UpcomingTask> tasks;
  final VoidCallback? onViewAll;
  final Function(UpcomingTask)? onTaskTap;

  const UpcomingTasksSection({
    super.key,
    required this.tasks,
    this.onViewAll,
    this.onTaskTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpaceSectionHeader(
          title: 'Tugas Mendatang',
          actionText: 'Lihat Semua',
          onAction: onViewAll,
        ),
        if (tasks.isEmpty)
          _buildEmptyState()
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tasks.length > 3 ? 3 : tasks.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: SpaceDimensions.spacing12),
            itemBuilder: (context, index) {
              return _UpcomingTaskItem(
                task: tasks[index],
                onTap: () => onTaskTap?.call(tasks[index]),
              );
            },
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return SpaceCard(
      child: Column(
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            size: SpaceDimensions.icon3xl,
            color: SpaceColors.success,
          ),
          const SizedBox(height: SpaceDimensions.spacing12),
          Text('Tidak ada tugas mendatang', style: SpaceTextStyles.titleSmall),
          const SizedBox(height: SpaceDimensions.spacing4),
          Text(
            'Semua tugas sudah selesai! 🎉',
            style: SpaceTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _UpcomingTaskItem extends StatelessWidget {
  final UpcomingTask task;
  final VoidCallback? onTap;

  const _UpcomingTaskItem({required this.task, this.onTap});

  Color get _priorityColor => switch (task.priority) {
    TaskPriority.urgent => SpaceColors.error,
    TaskPriority.high => SpaceColors.warning,
    TaskPriority.normal => SpaceColors.primary,
    TaskPriority.low => SpaceColors.textSecondary,
  };

  String get _typeLabel => switch (task.type) {
    TaskType.assignment => 'Tugas',
    TaskType.quiz => 'Kuis',
    TaskType.project => 'Proyek',
    TaskType.exam => 'Ujian',
  };

  String _formatDueDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);

    if (difference.isNegative) {
      return 'Terlambat';
    } else if (difference.inHours < 24) {
      return 'Hari ini, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Besok, ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari lagi';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Color _getDueDateColor(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);

    if (difference.isNegative) {
      return SpaceColors.error;
    } else if (difference.inHours < 24) {
      return SpaceColors.error;
    } else if (difference.inDays <= 2) {
      return SpaceColors.warning;
    } else {
      return SpaceColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SpaceCard(
      onTap: onTap,
      child: Row(
        children: [
          // Priority indicator
          Container(
            width: 4,
            height: 56,
            decoration: BoxDecoration(
              color: _priorityColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: SpaceDimensions.spacing12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: SpaceTextStyles.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: SpaceDimensions.spacing4),
                Row(
                  children: [
                    SpaceBadge(
                      text: _typeLabel,
                      backgroundColor: _priorityColor.withValues(alpha: 0.15),
                      textColor: _priorityColor,
                    ),
                    const SizedBox(width: SpaceDimensions.spacing8),
                    Expanded(
                      child: Text(
                        task.courseName,
                        style: SpaceTextStyles.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Due date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Icon(
              //   Icons.schedule_rounded,
              //   size: SpaceDimensions.iconSm,
              //   color: _getDueDateColor(task.dueDate),
              // ),
              // const SizedBox(height: SpaceDimensions.spacing4),
              Text(
                _formatDueDate(task.dueDate),
                style: SpaceTextStyles.labelSmall.copyWith(
                  color: _getDueDateColor(task.dueDate),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
