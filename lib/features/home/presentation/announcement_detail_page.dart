import 'package:flutter/material.dart';
import '../../../core/theme/space_theme.dart';
import 'widgets/announcements_section.dart';
import 'package:intl/intl.dart';

class AnnouncementDetailPage extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementDetailPage({super.key, required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpaceColors.background,
      appBar: AppBar(
        title: const Text('Detail Pengumuman'),
        backgroundColor: SpaceColors.primary,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(SpaceDimensions.spacing20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                announcement.title,
                style: SpaceTextStyles.headlineSmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: SpaceColors.textPrimary,
                ),
              ),
              const SizedBox(height: SpaceDimensions.spacing16),

              // Metadata (Date & Author)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    announcement.author ?? 'Admin UIMSpace',
                    style: SpaceTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    DateFormat('dd MMMM yyyy, HH:mm').format(announcement.date),
                    style: SpaceTextStyles.labelSmall.copyWith(
                      color: SpaceColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SpaceDimensions.spacing24),

              // Divider
              Container(
                height: 1,
                width: double.infinity,
                color: SpaceColors.border,
              ),
              const SizedBox(height: SpaceDimensions.spacing24),

              // Content
              Text(
                announcement.content,
                style: SpaceTextStyles.bodyLarge.copyWith(
                  color: SpaceColors.textPrimary,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
