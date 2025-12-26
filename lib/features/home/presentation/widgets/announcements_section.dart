import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/core/widgets/space_card.dart';
import 'package:uimspace_app/core/widgets/space_components.dart';

/// Model untuk data pengumuman
class Announcement {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final AnnouncementType type;
  final bool isRead;
  final String? author;

  const Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    this.type = AnnouncementType.info,
    this.isRead = false,
    this.author,
  });
}

enum AnnouncementType { info, important, urgent, event }

/// Widget untuk menampilkan pengumuman terbaru
class AnnouncementsSection extends StatelessWidget {
  final List<Announcement> announcements;
  final VoidCallback? onViewAll;
  final Function(Announcement)? onAnnouncementTap;

  const AnnouncementsSection({
    super.key,
    required this.announcements,
    this.onViewAll,
    this.onAnnouncementTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpaceSectionHeader(
          title: 'Pengumuman Terbaru',
          actionText: 'Lihat Semua',
          onAction: onViewAll,
        ),
        if (announcements.where((a) => !a.isRead).isEmpty)
          _buildEmptyState()
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1, // Focus on only one latest unread
            separatorBuilder: (context, index) =>
                const SizedBox(height: SpaceDimensions.spacing12),
            itemBuilder: (context, index) {
              final unreadAnnouncements = announcements
                  .where((a) => !a.isRead)
                  .toList();
              return _AnnouncementItem(
                announcement: unreadAnnouncements[index],
                onTap: () =>
                    onAnnouncementTap?.call(unreadAnnouncements[index]),
              );
            },
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return SpaceCard(
      child: Row(
        children: [
          Icon(
            Icons.notifications_none_rounded,
            size: SpaceDimensions.iconXl,
            color: SpaceColors.textSecondary,
          ),
          const SizedBox(width: SpaceDimensions.spacing12),
          Text(
            'Belum ada pengumuman terbaru',
            style: SpaceTextStyles.bodyMedium.copyWith(
              color: SpaceColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnnouncementItem extends StatelessWidget {
  final Announcement announcement;
  final VoidCallback? onTap;

  const _AnnouncementItem({required this.announcement, this.onTap});

  Color get _typeColor => switch (announcement.type) {
    AnnouncementType.urgent => SpaceColors.error,
    AnnouncementType.important => SpaceColors.warning,
    AnnouncementType.event => SpaceColors.secondary,
    AnnouncementType.info => SpaceColors.info,
  };

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inDays == 1) {
      return 'Kemarin';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari lalu';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SpaceCard(
      onTap: onTap,
      hasGlow:
          announcement.type == AnnouncementType.urgent ||
          announcement.type == AnnouncementType.important,
      borderColor: !announcement.isRead
          ? _typeColor.withValues(alpha: 0.5)
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and unread indicator
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  announcement.title,
                  style: SpaceTextStyles.titleSmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (!announcement.isRead) ...[
                const SizedBox(width: SpaceDimensions.spacing8),
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: SpaceColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: SpaceDimensions.spacing12),
          // Content preview
          Text(
            announcement.content,
            style: SpaceTextStyles.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: SpaceDimensions.spacing12),
          // Footer with date and author
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: SpaceDimensions.iconSm,
                color: SpaceColors.textSecondary,
              ),
              const SizedBox(width: SpaceDimensions.spacing4),
              Text(
                _formatDate(announcement.date),
                style: SpaceTextStyles.labelSmall,
              ),
              if (announcement.author != null) ...[
                const SizedBox(width: SpaceDimensions.spacing12),
                Icon(
                  Icons.person_outline_rounded,
                  size: SpaceDimensions.iconSm,
                  color: SpaceColors.textSecondary,
                ),
                const SizedBox(width: SpaceDimensions.spacing4),
                Expanded(
                  child: Text(
                    announcement.author!,
                    style: SpaceTextStyles.labelSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
