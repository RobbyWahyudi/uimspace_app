import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/core/widgets/space_components.dart';

/// Widget untuk menampilkan sapaan personal di beranda
class GreetingSection extends StatelessWidget {
  final String studentName;
  final String? avatarUrl;
  final VoidCallback? onProfileTap;

  const GreetingSection({
    super.key,
    required this.studentName,
    this.avatarUrl,
    this.onProfileTap,
  });

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Selamat Pagi';
    if (hour < 15) return 'Selamat Siang';
    if (hour < 18) return 'Selamat Sore';
    return 'Selamat Malam';
  }

  String get _motivationalText {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Semangat memulai hari! 🚀';
    if (hour < 15) return 'Tetap produktif! 💪';
    if (hour < 18) return 'Ayo selesaikan tugasmu! ✨';
    return 'Istirahat yang cukup ya! 🌙';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: SpaceDimensions.cardPadding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SpaceColors.primary.withValues(alpha: 0.15),
            SpaceColors.secondary.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: SpaceDimensions.cardRadius,
        border: Border.all(
          color: SpaceColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          SpaceAvatar(
            imageUrl: avatarUrl,
            name: studentName,
            size: SpaceDimensions.avatarXl,
            onTap: onProfileTap,
          ),
          const SizedBox(width: SpaceDimensions.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _greeting,
                  style: SpaceTextStyles.bodyMedium.copyWith(
                    color: SpaceColors.secondary,
                  ),
                ),
                const SizedBox(height: SpaceDimensions.spacing4),
                Text(
                  studentName,
                  style: SpaceTextStyles.headlineMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: SpaceDimensions.spacing4),
                Text(_motivationalText, style: SpaceTextStyles.bodySmall),
              ],
            ),
          ),
          Icon(
            Icons.rocket_launch_rounded,
            color: SpaceColors.secondary,
            size: SpaceDimensions.icon3xl,
          ),
        ],
      ),
    );
  }
}
