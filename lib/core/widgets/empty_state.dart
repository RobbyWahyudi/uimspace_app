import 'package:flutter/material.dart';
import '../theme/space_theme.dart';
import 'primary_button.dart';

/// UIMSpace Empty State
/// Widget untuk menampilkan state kosong dengan berbagai variasi
class SpaceEmptyState extends StatelessWidget {
  final String title;
  final String? description;
  final IconData? icon;
  final String? actionText;
  final VoidCallback? onAction;
  final Widget? customIcon;

  const SpaceEmptyState({
    super.key,
    required this.title,
    this.description,
    this.icon,
    this.actionText,
    this.onAction,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: SpaceDimensions.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with glow effect
            Container(
              width: SpaceDimensions.avatar2xl,
              height: SpaceDimensions.avatar2xl,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SpaceColors.surfaceVariant,
                boxShadow: [
                  BoxShadow(
                    color: SpaceColors.secondary.withValues(alpha: 0.1),
                    blurRadius: 24,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child:
                  customIcon ??
                  Icon(
                    icon ?? Icons.inbox_outlined,
                    size: SpaceDimensions.icon2xl,
                    color: SpaceColors.textSecondary,
                  ),
            ),
            const SizedBox(height: SpaceDimensions.spacing24),

            // Title
            Text(
              title,
              style: SpaceTextStyles.titleLarge,
              textAlign: TextAlign.center,
            ),

            // Description
            if (description != null) ...[
              const SizedBox(height: SpaceDimensions.spacing8),
              Text(
                description!,
                style: SpaceTextStyles.bodyMedium.copyWith(
                  color: SpaceColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],

            // Action button
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: SpaceDimensions.spacing24),
              SpacePrimaryButton(text: actionText!, onPressed: onAction),
            ],
          ],
        ),
      ),
    );
  }
}

/// Empty state khusus untuk tidak ada mata kuliah
class SpaceEmptyStateCourse extends StatelessWidget {
  final VoidCallback? onBrowseCourses;

  const SpaceEmptyStateCourse({super.key, this.onBrowseCourses});

  @override
  Widget build(BuildContext context) {
    return SpaceEmptyState(
      icon: Icons.school_outlined,
      title: 'Belum Ada Mata Kuliah',
      description:
          'Anda belum terdaftar di mata kuliah manapun.\nMulai jelajahi mata kuliah yang tersedia.',
      actionText: onBrowseCourses != null ? 'Jelajahi Mata Kuliah' : null,
      onAction: onBrowseCourses,
    );
  }
}

/// Empty state khusus untuk tidak ada notifikasi
class SpaceEmptyStateNotification extends StatelessWidget {
  const SpaceEmptyStateNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpaceEmptyState(
      icon: Icons.notifications_none_outlined,
      title: 'Tidak Ada Notifikasi',
      description:
          'Anda akan menerima notifikasi tentang\npengumuman, tugas, dan aktivitas lainnya.',
    );
  }
}

/// Empty state khusus untuk tidak ada tugas
class SpaceEmptyStateAssignment extends StatelessWidget {
  const SpaceEmptyStateAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpaceEmptyState(
      icon: Icons.assignment_outlined,
      title: 'Tidak Ada Tugas',
      description: 'Belum ada tugas yang perlu dikerjakan.\nSantai dulu! 🎉',
    );
  }
}

/// Empty state khusus untuk pencarian tanpa hasil
class SpaceEmptyStateSearch extends StatelessWidget {
  final String searchQuery;
  final VoidCallback? onClearSearch;

  const SpaceEmptyStateSearch({
    super.key,
    required this.searchQuery,
    this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return SpaceEmptyState(
      icon: Icons.search_off_outlined,
      title: 'Tidak Ditemukan',
      description:
          'Tidak ada hasil untuk "$searchQuery".\nCoba kata kunci lain.',
      actionText: onClearSearch != null ? 'Hapus Pencarian' : null,
      onAction: onClearSearch,
    );
  }
}

/// Empty state khusus untuk materi kosong
class SpaceEmptyStateMaterial extends StatelessWidget {
  const SpaceEmptyStateMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpaceEmptyState(
      icon: Icons.folder_open_outlined,
      title: 'Belum Ada Materi',
      description: 'Dosen belum mengunggah materi\nuntuk mata kuliah ini.',
    );
  }
}

/// Empty state khusus untuk quiz
class SpaceEmptyStateQuiz extends StatelessWidget {
  const SpaceEmptyStateQuiz({super.key});

  @override
  Widget build(BuildContext context) {
    return const SpaceEmptyState(
      icon: Icons.quiz_outlined,
      title: 'Tidak Ada Quiz',
      description: 'Belum ada quiz yang tersedia\nuntuk dikerjakan saat ini.',
    );
  }
}
