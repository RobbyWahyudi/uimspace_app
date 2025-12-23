import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/core/widgets/space_card.dart';
import 'package:uimspace_app/core/widgets/space_components.dart';
import 'package:uimspace_app/features/course/data/models/course_models.dart';

/// Widget untuk menampilkan ringkasan progres kelas
class ClassProgressSection extends StatelessWidget {
  final List<CourseProgress> courses;
  final VoidCallback? onViewAll;
  final Function(CourseProgress)? onCourseTap;

  const ClassProgressSection({
    super.key,
    required this.courses,
    this.onViewAll,
    this.onCourseTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpaceSectionHeader(
          title: 'Progres Kelas',
          actionText: 'Lihat Semua',
          onAction: onViewAll,
        ),
        // Summary Stats Card
        _buildSummaryCard(),
        const SizedBox(height: SpaceDimensions.spacing16),
        // Course Progress List
        if (courses.isEmpty)
          _buildEmptyState()
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: courses.length > 4 ? 4 : courses.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: SpaceDimensions.spacing12),
            itemBuilder: (context, index) {
              return _CourseProgressItem(
                course: courses[index],
                onTap: () => onCourseTap?.call(courses[index]),
              );
            },
          ),
      ],
    );
  }

  Widget _buildSummaryCard() {
    final totalCompleted = courses.fold(
      0,
      (sum, c) => sum + c.completedModules,
    );
    final totalModules = courses.fold(0, (sum, c) => sum + c.totalModules);
    final averageProgress = courses.isNotEmpty
        ? courses.fold(0.0, (sum, c) => sum + c.progressPercentage) /
              courses.length
        : 0.0;
    final averageGrade = courses.isNotEmpty
        ? courses.fold(0.0, (sum, c) => sum + c.grade) / courses.length
        : 0.0;

    return SpaceCard(
      hasGlow: true,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  icon: Icons.school_rounded,
                  label: 'Total Kelas',
                  value: courses.length.toString(),
                  color: SpaceColors.primary,
                ),
              ),
              Container(width: 1, height: 60, color: SpaceColors.divider),
              Expanded(
                child: _StatItem(
                  icon: Icons.check_circle_rounded,
                  label: 'Modul Selesai',
                  value: '$totalCompleted/$totalModules',
                  color: SpaceColors.success,
                ),
              ),
            ],
          ),
          const SpaceDivider(),
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  icon: Icons.trending_up_rounded,
                  label: 'Rata-rata Progres',
                  value: '${(averageProgress * 100).toInt()}%',
                  color: SpaceColors.secondary,
                ),
              ),
              Container(width: 1, height: 60, color: SpaceColors.divider),
              Expanded(
                child: _StatItem(
                  icon: Icons.grade_rounded,
                  label: 'Rata-rata Nilai',
                  value: averageGrade.toStringAsFixed(1),
                  color: SpaceColors.warning,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return SpaceCard(
      child: Column(
        children: [
          Icon(
            Icons.school_outlined,
            size: SpaceDimensions.icon3xl,
            color: SpaceColors.textSecondary,
          ),
          const SizedBox(height: SpaceDimensions.spacing12),
          Text('Belum ada kelas terdaftar', style: SpaceTextStyles.titleSmall),
          const SizedBox(height: SpaceDimensions.spacing4),
          Text(
            'Daftarkan diri ke kelas untuk mulai belajar',
            style: SpaceTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(SpaceDimensions.spacing10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: SpaceDimensions.iconMd),
        ),
        const SizedBox(height: SpaceDimensions.spacing8),
        Text(
          value,
          style: SpaceTextStyles.headlineSmall.copyWith(color: color),
        ),
        const SizedBox(height: SpaceDimensions.spacing4),
        Text(
          label,
          style: SpaceTextStyles.labelSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _CourseProgressItem extends StatelessWidget {
  final CourseProgress course;
  final VoidCallback? onTap;

  const _CourseProgressItem({required this.course, this.onTap});

  Color get _progressColor {
    final progress = course.progressPercentage;
    if (progress >= 0.8) return SpaceColors.success;
    if (progress >= 0.5) return SpaceColors.secondary;
    if (progress >= 0.25) return SpaceColors.warning;
    return SpaceColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    final color = course.accentColor ?? _progressColor;

    return SpaceCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Course Icon
              Container(
                width: SpaceDimensions.iconXl,
                height: SpaceDimensions.iconXl,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(SpaceDimensions.radiusSm),
                ),
                child: Icon(
                  Icons.book_outlined,
                  color: color,
                  size: SpaceDimensions.iconMd,
                ),
              ),
              const SizedBox(width: SpaceDimensions.spacing12),
              // Course info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.code,
                      style: SpaceTextStyles.labelSmall.copyWith(color: color),
                    ),
                    const SizedBox(height: SpaceDimensions.spacing2),
                    Text(
                      course.name,
                      style: SpaceTextStyles.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Grade badge
              if (course.grade > 0)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpaceDimensions.spacing12,
                    vertical: SpaceDimensions.spacing6,
                  ),
                  decoration: BoxDecoration(
                    color: SpaceColors.success.withValues(alpha: 0.15),
                    borderRadius: SpaceDimensions.chipRadius,
                  ),
                  child: Text(
                    course.grade.toStringAsFixed(1),
                    style: SpaceTextStyles.labelLarge.copyWith(
                      color: SpaceColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: SpaceDimensions.spacing12),
          // Progress bar
          SpaceProgressBar(
            value: course.progressPercentage,
            color: color,
            label:
                '${course.completedModules} dari ${course.totalModules} modul selesai',
          ),
        ],
      ),
    );
  }
}
