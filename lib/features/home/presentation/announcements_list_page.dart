import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/core/widgets/space_card.dart';
import 'widgets/announcements_section.dart';
import 'package:intl/intl.dart';

class AnnouncementsListPage extends StatefulWidget {
  final List<Announcement> announcements;

  const AnnouncementsListPage({super.key, required this.announcements});

  @override
  State<AnnouncementsListPage> createState() => _AnnouncementsListPageState();
}

class _AnnouncementsListPageState extends State<AnnouncementsListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<Announcement> get _filteredAnnouncements {
    List<Announcement> list = widget.announcements;

    // Tab Filter
    if (_tabController.index == 1) {
      list = list.where((a) => !a.isRead).toList();
    }

    // Search Filter
    if (_searchQuery.isNotEmpty) {
      list = list
          .where(
            (a) =>
                a.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                a.content.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }

    // Sort by date (Newest first)
    list.sort((a, b) => b.date.compareTo(a.date));

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpaceColors.background,
      appBar: AppBar(
        title: const Text('Pengumuman'),
        backgroundColor: SpaceColors.primary,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
          onTap: (index) => setState(() {}),
          tabs: const [
            Tab(text: 'Semua'),
            Tab(text: 'Belum Dibaca'),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSearchField(),
            Expanded(
              child: _filteredAnnouncements.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredAnnouncements.length,
                      itemBuilder: (context, index) {
                        return _AnnouncementListCard(
                          announcement: _filteredAnnouncements[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Cari pengumuman...',
          prefixIcon: const Icon(
            Icons.search,
            color: SpaceColors.textSecondary,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: SpaceColors.textSecondary,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
              : null,
          filled: true,
          fillColor: SpaceColors.surfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
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
          // Navigate to detail
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
