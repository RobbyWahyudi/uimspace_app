import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:uimspace_app/core/theme/space_theme.dart';
import 'package:uimspace_app/navigation/bottom_navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('Email dan password tidak boleh kosong');
      return;
    }

    if (!email.endsWith('@uim.ac.id')) {
      _showError('Gunakan email institusi (@uim.ac.id)');
      return;
    }

    setState(() => _isLoading = true);

    // Mock login delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);

        // Mock success check (password 'asdf' for failure test)
        if (password == 'asdf') {
          _showError('Password SSO salah. Silakan periksa kembali.');
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainNavigationShell(),
            ),
          );
        }
      }
    });
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return DefaultTabController(
          length: 2,
          child: Dialog(
            backgroundColor: SpaceColors.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SpaceDimensions.radiusLg),
              side: const BorderSide(color: SpaceColors.border),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              constraints: const BoxConstraints(maxHeight: 500),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tab Bar Header
                  Container(
                    decoration: BoxDecoration(
                      color: SpaceColors.surfaceVariant.withValues(alpha: 0.5),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(SpaceDimensions.radiusLg),
                      ),
                    ),
                    child: Column(
                      children: [
                        const TabBar(
                          dividerColor: Colors.transparent,
                          indicatorColor: SpaceColors.primary,
                          labelColor: SpaceColors.primary,
                          unselectedLabelColor: SpaceColors.textSecondary,
                          tabs: [
                            Tab(text: 'INDONESIA'),
                            Tab(text: 'ENGLISH'),
                          ],
                        ),
                        Container(height: 1, color: SpaceColors.border),
                      ],
                    ),
                  ),

                  // Tab Content
                  Flexible(
                    child: TabBarView(
                      children: [
                        _buildHelpContent(isEnglish: false),
                        _buildHelpContent(isEnglish: true),
                      ],
                    ),
                  ),

                  // Footer
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SpaceColors.surfaceVariant,
                        foregroundColor: SpaceColors.textPrimary,
                        minimumSize: const Size(double.infinity, 44),
                      ),
                      child: const Text('Tutup'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHelpContent({required bool isEnglish}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHelpSection(
            isEnglish ? 'Access Control' : 'Kontrol Akses',
            isEnglish
                ? 'Access is only for Lecturers and Students of Universitas Islam Madura.'
                : 'Akses hanya untuk Dosen dan Mahasiswa Universitas Islam Madura.',
          ),
          const SizedBox(height: 16),
          _buildHelpSection(
            isEnglish ? 'Login Instructions' : 'Instruksi Login',
            isEnglish
                ? 'Login using SIMAT Account by following these instructions:\n\n'
                      '• Username (SIMAT Account) + "@uim.ac.id"\n'
                      '• Password (SIMAT Account) in the Password field.'
                : 'Login menggunakan Akun SIMAT dengan mengikuti petunjuk berikut:\n\n'
                      '• Username (Akun SIMAT) ditambahkan "@uim.ac.id"\n'
                      '• Password (Akun SIMAT) pada kolom Password.',
          ),
          const SizedBox(height: 16),
          _buildHelpSection(
            isEnglish ? 'Authentication Issue' : 'Masalah Autentikasi',
            isEnglish
                ? 'Failed authentication is often caused by not changing your password to a "Strong Password".\n\n'
                      'Make sure you have changed your password in SIMAT system.'
                : 'Kegagalan yang terjadi pada Autentikasi disebabkan oleh Anda belum mengubah Password Anda menjadi "Strong Password".\n\n'
                      'Pastikan Anda telah melakukan perubahan Password di SIMAT.',
          ),
          const SizedBox(height: 24),
          const Divider(color: SpaceColors.border),
          const SizedBox(height: 16),
          Text(
            isEnglish ? 'Contact Helpdesk' : 'Hubungi Helpdesk',
            style: SpaceTextStyles.titleSmall.copyWith(
              fontWeight: FontWeight.bold,
              color: SpaceColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          _buildContactItem(Icons.email_outlined, 'uimspace@uim.ac.id'),
          const SizedBox(height: 8),
          _buildContactItem(Icons.chat_rounded, '+62 821-1666-3563'),
        ],
      ),
    );
  }

  Widget _buildHelpSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: SpaceTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: SpaceTextStyles.bodySmall.copyWith(
            color: SpaceColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: SpaceColors.textSecondary),
        const SizedBox(width: 12),
        Text(
          text,
          style: SpaceTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: SpaceColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(
          label: 'Bantuan',
          textColor: Colors.white,
          onPressed: _showHelpDialog,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpaceColors.background,
      body: Stack(
        children: [
          // Background Decorative Elements
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SpaceColors.primary.withValues(alpha: 0.15),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SpaceColors.secondary.withValues(alpha: 0.1),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo Section
                    Center(
                      child: Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 100,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'UIMSpace',
                        style: SpaceTextStyles.headlineMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Learning Management System',
                        style: SpaceTextStyles.bodyMedium.copyWith(
                          color: SpaceColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Login Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: SpaceColors.surface.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(
                          SpaceDimensions.radius2xl,
                        ),
                        border: Border.all(color: SpaceColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selamat Datang',
                            style: SpaceTextStyles.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Masuk menggunakan akun SIMAT Anda.',
                            style: SpaceTextStyles.bodySmall.copyWith(
                              color: SpaceColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Email Field
                          _buildLabel('Email'),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: _emailController,
                            hintText: 'username@uim.ac.id',
                            icon: Icons.alternate_email_rounded,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),

                          // Password Field
                          _buildLabel('Password'),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: _passwordController,
                            hintText: '••••••••',
                            icon: Icons.lock_outline_rounded,
                            isPassword: true,
                            isPasswordVisible: _isPasswordVisible,
                            onToggleVisibility: () {
                              setState(
                                () => _isPasswordVisible = !_isPasswordVisible,
                              );
                            },
                          ),
                          const SizedBox(height: 12),

                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Fitur ini belum tersedia'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              child: Text(
                                'Lupa Password?',
                                style: SpaceTextStyles.bodySmall.copyWith(
                                  color: SpaceColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Login Button
                          ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: SpaceColors.primary,
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  SpaceDimensions.radiusMd,
                                ),
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
                                    'Masuk',
                                    style: SpaceTextStyles.titleSmall.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Footer
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: SpaceTextStyles.bodySmall.copyWith(
                            color: SpaceColors.textSecondary,
                          ),
                          children: [
                            const TextSpan(text: 'Butuh bantuan? '),
                            TextSpan(
                              text: 'Hubungi IT Support',
                              style: const TextStyle(
                                color: SpaceColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _showHelpDialog,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: SpaceTextStyles.labelMedium.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onToggleVisibility,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      keyboardType: keyboardType,
      style: SpaceTextStyles.bodyMedium,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: SpaceTextStyles.bodyMedium.copyWith(
          color: SpaceColors.textSecondary.withValues(alpha: 0.5),
        ),
        prefixIcon: Icon(icon, color: SpaceColors.primary, size: 20),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: SpaceColors.textSecondary,
                  size: 20,
                ),
                onPressed: onToggleVisibility,
              )
            : null,
        filled: true,
        fillColor: SpaceColors.surfaceVariant.withValues(alpha: 0.3),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SpaceDimensions.radiusMd),
          borderSide: const BorderSide(color: SpaceColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SpaceDimensions.radiusMd),
          borderSide: const BorderSide(color: SpaceColors.primary, width: 2),
        ),
      ),
    );
  }
}
