import 'package:flutter/material.dart';
import '../../../core/theme/space_theme.dart';
import '../../../core/widgets/space_card.dart' hide NotificationType;
import '../models/notification_model.dart';
import 'notification_controller.dart';
import '../../home/presentation/announcements_list_page.dart';
import '../../home/presentation/widgets/announcements_section.dart';

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
        title: Text(
          'Notifikasi',
          style: SpaceTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              if (_controller.unreadCount > 0) {
                return IconButton(
                  onPressed: () => _controller.markAllAsRead(),
                  icon: const Icon(Icons.done_all_rounded),
                  tooltip: 'Tandai Semua Dibaca',
                );
              }
              return const SizedBox.shrink();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () => _showClearDialog(),
              icon: const Icon(Icons.delete_sweep_outlined),
              tooltip: 'Hapus Semua',
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            final notifications = _controller.notifications;

            if (notifications.isEmpty) {
              return _buildEmptyState();
            }

            return ListView(
              padding: const EdgeInsets.all(SpaceDimensions.spacing16),
              children: [
                // Announcement Navigation Card
                _buildAnnouncementsNavCard(),

                const SizedBox(height: SpaceDimensions.spacing24),

                // Notifications Label
                Text(
                  'Riwayat Notifikasi',
                  style: SpaceTextStyles.titleSmall.copyWith(
                    color: SpaceColors.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: SpaceDimensions.spacing12),

                // Notifications List
                ...List.generate(notifications.length, (index) {
                  final item = notifications[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: SpaceDimensions.spacing12,
                    ),
                    child: _NotificationItem(
                      notification: item,
                      onTap: () => _controller.markAsRead(item.id),
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAnnouncementsNavCard() {
    return SpaceCard(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnnouncementsListPage(
              announcements: [
                Announcement(
                  id: '1',
                  title: 'Jadwal UAS Semester Ganjil 2024/2025',
                  content:
                      'Ujian Akhir Semester akan dilaksanakan pada tanggal 15-25 Januari 2025. Pastikan semua mahasiswa sudah menyelesaikan administrasi perkuliahan.',
                  date: DateTime.now().subtract(const Duration(hours: 2)),
                  type: AnnouncementType.important,
                  isRead: false,
                  author: 'Bagian Akademik',
                ),
                Announcement(
                  id: '2',
                  title: 'Seminar Nasional Teknologi Informasi',
                  content:
                      'Fakultas Teknik mengadakan Seminar Nasional dengan tema "Artificial Intelligence & Future of Education". Pendaftaran dibuka hingga 10 Januari 2025.',
                  date: DateTime.now().subtract(const Duration(days: 1)),
                  type: AnnouncementType.event,
                  isRead: true,
                  author: 'Fakultas Teknik',
                ),
              ],
            ),
          ),
        );
      },
      backgroundColor: SpaceColors.primary.withValues(alpha: 0.1),
      borderColor: SpaceColors.primary.withValues(alpha: 0.3),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pengumuman Kampus',
                  style: SpaceTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Lihat semua informasi dan pengumuman terbaru',
                  style: SpaceTextStyles.bodySmall.copyWith(
                    color: SpaceColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: SpaceColors.textSecondary,
          ),
        ],
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
