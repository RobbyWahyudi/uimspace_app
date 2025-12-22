import 'package:flutter/material.dart';
import '../theme/space_theme.dart';

/// UIMSpace Card - Base card widget
class SpaceCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool hasBorder;
  final bool hasGlow;
  final Color? backgroundColor;
  final Color? borderColor;

  const SpaceCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.hasBorder = true,
    this.hasGlow = false,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? SpaceColors.surface,
        borderRadius: SpaceDimensions.cardRadius,
        border: hasBorder
            ? Border.all(color: borderColor ?? SpaceColors.border, width: 1)
            : null,
        boxShadow: hasGlow
            ? [
                BoxShadow(
                  color: SpaceColors.primary.withValues(alpha: 0.15),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: padding ?? SpaceDimensions.cardPadding,
        child: child,
      ),
    );

    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: SpaceDimensions.cardRadius,
        child: card,
      );
    }

    return card;
  }
}

enum AssignmentStatus { pending, submitted, graded, overdue }

enum NotificationType { info, success, warning, error }

/// Card untuk Course/Mata Kuliah
class SpaceCourseCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? code;
  final IconData? icon;
  final Color? accentColor;
  final VoidCallback? onTap;
  final int? progress;
  final String? instructor;

  const SpaceCourseCard({
    super.key,
    required this.title,
    this.subtitle,
    this.code,
    this.icon,
    this.accentColor,
    this.onTap,
    this.progress,
    this.instructor,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? SpaceColors.primary;

    return SpaceCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: SpaceDimensions.icon3xl,
                height: SpaceDimensions.icon3xl,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(SpaceDimensions.radiusSm),
                ),
                child: Icon(
                  icon ?? Icons.school_outlined,
                  color: color,
                  size: SpaceDimensions.iconLg,
                ),
              ),
              const SizedBox(width: SpaceDimensions.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (code != null)
                      Text(
                        code!,
                        style: SpaceTextStyles.labelSmall.copyWith(
                          color: color,
                        ),
                      ),
                    Text(
                      title,
                      style: SpaceTextStyles.courseName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (instructor != null) ...[
                      const SizedBox(height: SpaceDimensions.spacing4),
                      Text(instructor!, style: SpaceTextStyles.bodySmall),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (progress != null) ...[
            const SizedBox(height: SpaceDimensions.spacing16),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      SpaceDimensions.radiusXs,
                    ),
                    child: LinearProgressIndicator(
                      value: progress! / 100,
                      backgroundColor: SpaceColors.surfaceVariant,
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      minHeight: 6,
                    ),
                  ),
                ),
                const SizedBox(width: SpaceDimensions.spacing12),
                Text(
                  '$progress%',
                  style: SpaceTextStyles.labelSmall.copyWith(color: color),
                ),
              ],
            ),
          ],
          if (subtitle != null) ...[
            const SizedBox(height: SpaceDimensions.spacing12),
            Text(
              subtitle!,
              style: SpaceTextStyles.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}

/// Card untuk Assignment/Tugas
class SpaceAssignmentCard extends StatelessWidget {
  final String title;
  final String courseName;
  final DateTime? dueDate;
  final AssignmentStatus status;
  final VoidCallback? onTap;
  final int? score;

  const SpaceAssignmentCard({
    super.key,
    required this.title,
    required this.courseName,
    this.dueDate,
    this.status = AssignmentStatus.pending,
    this.onTap,
    this.score,
  });

  Color get _statusColor => switch (status) {
    AssignmentStatus.pending => SpaceColors.warning,
    AssignmentStatus.submitted => SpaceColors.info,
    AssignmentStatus.graded => SpaceColors.success,
    AssignmentStatus.overdue => SpaceColors.error,
  };

  String get _statusText => switch (status) {
    AssignmentStatus.pending => 'Belum Dikerjakan',
    AssignmentStatus.submitted => 'Terkirim',
    AssignmentStatus.graded => 'Dinilai',
    AssignmentStatus.overdue => 'Terlambat',
  };

  IconData get _statusIcon => switch (status) {
    AssignmentStatus.pending => Icons.schedule,
    AssignmentStatus.submitted => Icons.check_circle_outline,
    AssignmentStatus.graded => Icons.grading,
    AssignmentStatus.overdue => Icons.warning_amber,
  };

  @override
  Widget build(BuildContext context) {
    return SpaceCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: SpaceDimensions.iconXl,
                height: SpaceDimensions.iconXl,
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _statusIcon,
                  color: _statusColor,
                  size: SpaceDimensions.iconMd,
                ),
              ),
              const SizedBox(width: SpaceDimensions.spacing12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: SpaceTextStyles.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: SpaceDimensions.spacing4),
                    Text(courseName, style: SpaceTextStyles.bodySmall),
                  ],
                ),
              ),
              if (status == AssignmentStatus.graded && score != null)
                Container(
                  padding: SpaceDimensions.chipPadding,
                  decoration: BoxDecoration(
                    color: SpaceColors.success.withValues(alpha: 0.15),
                    borderRadius: SpaceDimensions.chipRadius,
                  ),
                  child: Text(
                    '$score',
                    style: SpaceTextStyles.grade.copyWith(
                      fontSize: 18,
                      color: SpaceColors.success,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: SpaceDimensions.spacing12),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpaceDimensions.spacing8,
                  vertical: SpaceDimensions.spacing4,
                ),
                decoration: BoxDecoration(
                  color: _statusColor.withValues(alpha: 0.15),
                  borderRadius: SpaceDimensions.chipRadius,
                ),
                child: Text(
                  _statusText,
                  style: SpaceTextStyles.badge.copyWith(color: _statusColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
