import 'package:flutter/material.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';

/// Halaman Kelas Saya (My Courses)
/// Placeholder tanpa konten
class MyCoursesPage extends StatelessWidget {
  const MyCoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelas Saya'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            tooltip: 'Cari Kelas',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: SpaceDimensions.icon3xl,
              color: SpaceColors.textSecondary,
            ),
            const SizedBox(height: SpaceDimensions.spacing16),
            Text('Halaman Kelas Saya', style: SpaceTextStyles.titleMedium),
            const SizedBox(height: SpaceDimensions.spacing8),
            Text('Konten akan ditambahkan', style: SpaceTextStyles.bodySmall),
          ],
        ),
      ),
    );
  }
}
