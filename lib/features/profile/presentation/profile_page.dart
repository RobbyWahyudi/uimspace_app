import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';

/// Halaman Profil (Profile)
/// Placeholder tanpa konten
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Pengaturan',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline,
              size: SpaceDimensions.icon3xl,
              color: SpaceColors.textSecondary,
            ),
            const SizedBox(height: SpaceDimensions.spacing16),
            Text('Halaman Profil', style: SpaceTextStyles.titleMedium),
            const SizedBox(height: SpaceDimensions.spacing8),
            Text('Konten akan ditambahkan', style: SpaceTextStyles.bodySmall),
          ],
        ),
      ),
    );
  }
}
