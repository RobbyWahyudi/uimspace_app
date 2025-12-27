import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/core/widgets/space_card.dart';
import 'widgets/announcements_section.dart';
import 'package:intl/intl.dart';
import 'announcement_detail_page.dart';

class AnnouncementsListPage extends StatefulWidget {
  final List<Announcement> announcements;

  const AnnouncementsListPage({super.key, required this.announcements});

  @override
  State<AnnouncementsListPage> createState() => _AnnouncementsListPageState();
}

class _AnnouncementsListPageState extends State<AnnouncementsListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Announcement> get _sortedAnnouncements {
    List<Announcement> list = widget.announcements;

    // Sort by date (Newest first)
    list.sort((a, b) => b.date.compareTo(a.date));

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpaceColors.background,
      appBar: AppBar(
        title: Text(
          'Pengumuman',
          style: SpaceTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: SpaceColors.background,
        foregroundColor: SpaceColors.textPrimary,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: _sortedAnnouncements.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _sortedAnnouncements.length,
                itemBuilder: (context, index) {
                  return _AnnouncementListCard(
                    announcement: _sortedAnnouncements[index],
                  );
                },
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 64,
            color: SpaceColors.textSecondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada pengumuman ditemukan',
            style: SpaceTextStyles.titleMedium.copyWith(
              color: SpaceColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _AnnouncementListCard extends StatelessWidget {
  final Announcement announcement;

  const _AnnouncementListCard({required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: SpaceCard(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AnnouncementDetailPage(announcement: announcement),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!announcement.isRead)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: SpaceColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            else
              const SizedBox(height: 8),
            const SizedBox(height: 4),
            Text(
              announcement.title,
              style: SpaceTextStyles.titleMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              announcement.content,
              style: SpaceTextStyles.bodySmall.copyWith(
                color: SpaceColors.textSecondary,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: SpaceColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  DateFormat('dd MMM yyyy, HH:mm').format(announcement.date),
                  style: SpaceTextStyles.labelSmall.copyWith(
                    color: SpaceColors.textSecondary,
                  ),
                ),
                if (announcement.author != null) ...[
                  const Spacer(),
                  Text(
                    'Oleh: ${announcement.author}',
                    style: SpaceTextStyles.labelSmall.copyWith(
                      color: SpaceColors.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
