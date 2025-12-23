import 'package:flutter/material.dart';
import '../../../core/theme/space_theme.dart';
import '../../../core/widgets/space_card.dart' hide NotificationType;
import '../models/notification_model.dart';
import 'notification_controller.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationController _controller = NotificationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpaceColors.background,
      appBar: AppBar(
        title: const Text('Notifikasi'),
        centerTitle: false,
        actions: [
          ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              if (_controller.unreadCount > 0) {
                return TextButton(
                  onPressed: () => _controller.markAllAsRead(),
                  child: const Text('Tandai Semua Dibaca'),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          IconButton(
            onPressed: () => _showClearDialog(),
            icon: const Icon(Icons.delete_sweep_outlined),
            tooltip: 'Hapus Semua',
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          final notifications = _controller.notifications;

          if (notifications.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.separated(
            padding: const EdgeInsets.all(SpaceDimensions.spacing16),
            itemCount: notifications.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: SpaceDimensions.spacing12),
            itemBuilder: (context, index) {
              final item = notifications[index];
              return _NotificationItem(
                notification: item,
                onTap: () => _controller.markAsRead(item.id),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(SpaceDimensions.spacing24),
            decoration: BoxDecoration(
              color: SpaceColors.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_off_outlined,
              size: 64,
              color: SpaceColors.textDisabled,
            ),
          ),
          const SizedBox(height: SpaceDimensions.spacing24),
          Text('Belum ada notifikasi', style: SpaceTextStyles.titleMedium),
          const SizedBox(height: SpaceDimensions.spacing8),
          Text(
            'Semua pemberitahuan akan muncul di sini',
            style: SpaceTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }

  void _showClearDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Semua Notifikasi?'),
        content: const Text(
          'Tindakan ini tidak dapat dibatalkan. Semua riwayat notifikasi Anda akan dihapus.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              _controller.clearAll();
              Navigator.pop(context);
            },
            child: Text(
              'Hapus Semua',
              style: TextStyle(color: SpaceColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const _NotificationItem({required this.notification, required this.onTap});

  IconData get _icon => switch (notification.type) {
    NotificationType.assignmentSubmitted => Icons.check_circle_outline_rounded,
    NotificationType.deadlineApproaching => Icons.timer_outlined,
    NotificationType.announcement => Icons.campaign_outlined,
    NotificationType.gradeUpdate => Icons.grading_rounded,
  };

  Color get _color => switch (notification.type) {
    NotificationType.assignmentSubmitted => SpaceColors.success,
    NotificationType.deadlineApproaching => SpaceColors.warning,
    NotificationType.announcement => SpaceColors.info,
    NotificationType.gradeUpdate => SpaceColors.secondary,
  };

  @override
  Widget build(BuildContext context) {
    return SpaceCard(
      onTap: onTap,
      backgroundColor: notification.isRead
          ? SpaceColors.surface
          : SpaceColors.primary.withValues(alpha: 0.05),
      borderColor: notification.isRead
          ? SpaceColors.border
          : SpaceColors.primary.withValues(alpha: 0.2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon with color circle
          Container(
            padding: const EdgeInsets.all(SpaceDimensions.spacing10),
            decoration: BoxDecoration(
              color: _color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(_icon, color: _color, size: SpaceDimensions.iconMd),
          ),
          const SizedBox(width: SpaceDimensions.spacing16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: SpaceTextStyles.titleSmall.copyWith(
                          fontWeight: notification.isRead
                              ? FontWeight.w500
                              : FontWeight.bold,
                        ),
                      ),
                    ),
                    if (!notification.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: SpaceColors.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: SpaceDimensions.spacing4),
                Text(
                  notification.message,
                  style: SpaceTextStyles.bodySmall.copyWith(
                    color: notification.isRead
                        ? SpaceColors.textSecondary
                        : SpaceColors.textPrimary,
                  ),
                ),
                const SizedBox(height: SpaceDimensions.spacing8),
                Row(
                  children: [
                    if (notification.courseName != null) ...[
                      Icon(
                        Icons.book_outlined,
                        size: 12,
                        color: SpaceColors.textDisabled,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        notification.courseName!,
                        style: SpaceTextStyles.labelSmall.copyWith(
                          fontSize: 10,
                          color: SpaceColors.textDisabled,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Icon(
                      Icons.access_time_rounded,
                      size: 12,
                      color: SpaceColors.textDisabled,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatTime(notification.timestamp),
                      style: SpaceTextStyles.labelSmall.copyWith(
                        fontSize: 10,
                        color: SpaceColors.textDisabled,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 60) return '${diff.inMinutes}m lalu';
    if (diff.inHours < 24) return '${diff.inHours}j lalu';
    if (diff.inDays == 1) return 'Kemarin';
    return '${time.day}/${time.month}';
  }
}
