import 'package:flutter/material.dart';
import '../../../core/theme/space_theme.dart';
import '../../../core/widgets/space_card.dart';
import '../../../core/widgets/space_components.dart';
import '../models/profile_model.dart';
import 'profile_controller.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileModel user;
  final ProfileController controller;

  const EditProfilePage({
    super.key,
    required this.user,
    required this.controller,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _phoneController = TextEditingController(text: widget.user.phone);
    _bioController = TextEditingController(text: widget.user.bio);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    setState(() => _isLoading = true);

    // Simulate saving process
    Future.delayed(const Duration(seconds: 1), () {
      final updatedUser = widget.user.copyWith(
        name: _nameController.text,
        phone: _phoneController.text,
        bio: _bioController.text,
      );

      widget.controller.updateProfile(updatedUser);

      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profil berhasil diperbarui'),
            backgroundColor: SpaceColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpaceColors.background,
      appBar: AppBar(
        title: Text(
          'Edit Profil',
          style: SpaceTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(SpaceDimensions.spacing20),
        child: Column(
          children: [
            // Avatar Section
            Center(
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: SpaceColors.primary, width: 2),
                    ),
                    child: SpaceAvatar(
                      name: widget.user.name,
                      imageUrl: widget.user.avatarUrl,
                      size: 100,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: SpaceColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: SpaceDimensions.spacing32),

            // Form Section
            SpaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    label: 'Nama Lengkap',
                    controller: _nameController,
                    icon: Icons.person_outline_rounded,
                  ),
                  const SizedBox(height: SpaceDimensions.spacing20),
                  _buildTextField(
                    label: 'Nomor Telepon',
                    controller: _phoneController,
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: SpaceDimensions.spacing20),
                  _buildTextField(
                    label: 'Bio',
                    controller: _bioController,
                    icon: Icons.info_outline_rounded,
                    maxLines: 3,
                  ),
                ],
              ),
            ),

            const SizedBox(height: SpaceDimensions.spacing40),

            // Save Button
            ElevatedButton(
              onPressed: _isLoading ? null : _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: SpaceColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SpaceDimensions.radiusMd),
                ),
                elevation: 0,
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Simpan Perubahan',
                      style: SpaceTextStyles.titleSmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: SpaceTextStyles.labelSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: SpaceColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: SpaceTextStyles.bodyMedium,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: SpaceColors.primary, size: 20),
            filled: true,
            fillColor: SpaceColors.surfaceVariant.withValues(alpha: 0.3),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: SpaceColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: SpaceColors.primary,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
