import 'package:flutter/material.dart';
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
          onPressed: () {
            // Mock help action
          },
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
                    const Center(
                      child: Hero(
                        tag: 'logo',
                        child: Icon(
                          Icons.auto_awesome_rounded,
                          size: 80,
                          color: SpaceColors.primary,
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
                        'Management Learning System',
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
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: SpaceColors.border),
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
                            'Masuk menggunakan akun universitas Anda.',
                            style: SpaceTextStyles.bodySmall.copyWith(
                              color: SpaceColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Email Field
                          _buildLabel('Email Institusi'),
                          const SizedBox(height: 8),
                          _buildTextField(
                            controller: _emailController,
                            hintText: 'nim@uim.ac.id',
                            icon: Icons.alternate_email_rounded,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),

                          // Password Field
                          _buildLabel('Password SSO'),
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
                            child: TextButton(
                              onPressed: () {},
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
                                borderRadius: BorderRadius.circular(16),
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
                                    'Masuk Ke Akun',
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
                              style: TextStyle(
                                color: SpaceColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
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
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SpaceColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: SpaceColors.primary, width: 2),
        ),
      ),
    );
  }
}
