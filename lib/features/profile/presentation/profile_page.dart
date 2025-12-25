import 'package:flutter/material.dart';
import '../../../core/theme/space_theme.dart';
import '../../../core/widgets/space_card.dart';
import '../../../core/widgets/space_components.dart';
import '../models/profile_model.dart';
import 'profile_controller.dart';
import 'edit_profile_page.dart';

/// Halaman Profil (Profile)
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController _controller = ProfileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpaceColors.background,
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          final user = _controller.user;
          return CustomScrollView(
            slivers: [
              _buildSliverAppBar(user),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(SpaceDimensions.spacing16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPersonalInfoSection(user),
                      const SizedBox(height: SpaceDimensions.spacing24),
                      _buildLoginHistorySection(),
                      const SizedBox(height: SpaceDimensions.spacing24),
                      _buildAccountActionsSection(context),
                      const SizedBox(height: SpaceDimensions.spacing40),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSliverAppBar(ProfileModel user) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: SpaceColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Gradient Background
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    SpaceColors.primary,
                    SpaceColors.primary.withValues(alpha: 0.8),
                    SpaceColors.secondary.withValues(alpha: 0.6),
                  ],
                ),
              ),
            ),
            // Abstract circles for design
            Positioned(
              top: -50,
              right: -50,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            // Profile Info
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: SpaceAvatar(
                        name: user.name,
                        imageUrl: user.avatarUrl,
                        size: 100,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          size: 20,
                          color: SpaceColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SpaceDimensions.spacing16),
                Text(
                  user.name,
                  style: SpaceTextStyles.headlineMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.major ?? 'Mahasiswa',
                  style: SpaceTextStyles.bodyMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditProfilePage(user: user, controller: _controller),
              ),
            );
          },
          icon: const Icon(Icons.edit_outlined, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection(ProfileModel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpaceSectionHeader(title: 'Data Diri'),
        SpaceCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              _buildInfoTile(
                icon: Icons.badge_outlined,
                label: 'NIM',
                value: user.studentId ?? '-',
              ),
              const SpaceDivider(margin: EdgeInsets.zero),
              _buildInfoTile(
                icon: Icons.email_outlined,
                label: 'Email',
                value: user.email,
              ),
              const SpaceDivider(margin: EdgeInsets.zero),
              _buildInfoTile(
                icon: Icons.phone_outlined,
                label: 'Nomor Telepon',
                value: user.phone,
              ),
              const SpaceDivider(margin: EdgeInsets.zero),
              _buildInfoTile(
                icon: Icons.info_outline,
                label: 'Bio',
                value: user.bio,
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(SpaceDimensions.spacing16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: SpaceColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(SpaceDimensions.radiusSm),
            ),
            child: Icon(icon, color: SpaceColors.primary, size: 20),
          ),
          const SizedBox(width: SpaceDimensions.spacing16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: SpaceTextStyles.labelSmall),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: SpaceTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginHistorySection() {
    final history = _controller.loginHistory;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpaceSectionHeader(title: 'Riwayat Login'),
        SpaceCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: List.generate(history.length, (index) {
              final item = history[index];
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: SpaceColors.secondary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item.deviceName.contains('Chrome')
                            ? Icons.laptop_windows_rounded
                            : Icons.phone_android_rounded,
                        color: SpaceColors.secondary,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      item.deviceName,
                      style: SpaceTextStyles.titleSmall,
                    ),
                    subtitle: Text(
                      '${item.ipAddress} • ${item.location}',
                      style: SpaceTextStyles.bodySmall,
                    ),
                    trailing: Text(
                      _formatDate(item.loginTime),
                      style: SpaceTextStyles.labelSmall,
                    ),
                  ),
                  if (index != history.length - 1)
                    const SpaceDivider(margin: EdgeInsets.zero),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountActionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SpaceSectionHeader(title: 'Akun'),
        SpaceCard(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfilePage(
                  user: _controller.user,
                  controller: _controller,
                ),
              ),
            );
          },
          child: Row(
            children: [
              Icon(Icons.person_outline, color: SpaceColors.textPrimary),
              const SizedBox(width: SpaceDimensions.spacing16),
              Expanded(
                child: Text('Edit Profil', style: SpaceTextStyles.titleSmall),
              ),
              Icon(Icons.chevron_right, color: SpaceColors.textSecondary),
            ],
          ),
        ),
        const SizedBox(height: SpaceDimensions.spacing12),
        SpaceCard(
          backgroundColor: SpaceColors.error.withValues(alpha: 0.05),
          borderColor: SpaceColors.error.withValues(alpha: 0.2),
          onTap: () => _showLogoutDialog(context),
          child: Row(
            children: [
              Icon(Icons.logout_rounded, color: SpaceColors.error),
              const SizedBox(width: SpaceDimensions.spacing16),
              Expanded(
                child: Text(
                  'Keluar',
                  style: SpaceTextStyles.titleSmall.copyWith(
                    color: SpaceColors.error,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar dari Akun?'),
        content: const Text(
          'Apakah Anda yakin ingin keluar? Anda harus login kembali untuk mengakses data Anda.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _controller.logout();
            },
            child: Text('Keluar', style: TextStyle(color: SpaceColors.error)),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m yang lalu';
    if (diff.inHours < 24) return '${diff.inHours}j yang lalu';
    return '${date.day}/${date.month}/${date.year}';
  }
}
