import 'package:flutter/material.dart';
import '../theme/space_theme.dart';
import 'primary_button.dart';

/// UIMSpace Error View
/// Widget untuk menampilkan error dengan berbagai variasi
class SpaceErrorView extends StatelessWidget {
  final String title;
  final String? message;
  final IconData? icon;
  final String? retryText;
  final VoidCallback? onRetry;
  final bool isCompact;

  const SpaceErrorView({
    super.key,
    required this.title,
    this.message,
    this.icon,
    this.retryText,
    this.onRetry,
    this.isCompact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      return _buildCompact();
    }
    return _buildFull();
  }

  Widget _buildFull() {
    return Center(
      child: Padding(
        padding: SpaceDimensions.screenPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon dengan error styling
            Container(
              width: SpaceDimensions.avatar2xl,
              height: SpaceDimensions.avatar2xl,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SpaceColors.error.withValues(alpha: 0.1),
              ),
              child: Icon(
                icon ?? Icons.error_outline,
                size: SpaceDimensions.icon2xl,
                color: SpaceColors.error,
              ),
            ),
            const SizedBox(height: SpaceDimensions.spacing24),

            // Title
            Text(
              title,
              style: SpaceTextStyles.titleLarge,
              textAlign: TextAlign.center,
            ),

            // Message
            if (message != null) ...[
              const SizedBox(height: SpaceDimensions.spacing8),
              Text(
                message!,
                style: SpaceTextStyles.bodyMedium.copyWith(
                  color: SpaceColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],

            // Retry button
            if (retryText != null && onRetry != null) ...[
              const SizedBox(height: SpaceDimensions.spacing24),
              SpacePrimaryButton(
                text: retryText!,
                onPressed: onRetry,
                leadingIcon: Icons.refresh,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCompact() {
    return Container(
      padding: SpaceDimensions.cardPadding,
      decoration: BoxDecoration(
        color: SpaceColors.error.withValues(alpha: 0.1),
        borderRadius: SpaceDimensions.cardRadius,
        border: Border.all(color: SpaceColors.error.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            icon ?? Icons.error_outline,
            color: SpaceColors.error,
            size: SpaceDimensions.iconLg,
          ),
          const SizedBox(width: SpaceDimensions.spacing12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: SpaceTextStyles.titleSmall),
                if (message != null) ...[
                  const SizedBox(height: SpaceDimensions.spacing4),
                  Text(
                    message!,
                    style: SpaceTextStyles.bodySmall.copyWith(
                      color: SpaceColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onRetry != null)
            IconButton(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, color: SpaceColors.error),
              tooltip: retryText ?? 'Coba Lagi',
            ),
        ],
      ),
    );
  }
}

/// Error view untuk network error
class SpaceNetworkError extends StatelessWidget {
  final VoidCallback? onRetry;

  const SpaceNetworkError({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SpaceErrorView(
      icon: Icons.wifi_off_outlined,
      title: 'Tidak Ada Koneksi',
      message: 'Periksa koneksi internet Anda\ndan coba lagi.',
      retryText: onRetry != null ? 'Coba Lagi' : null,
      onRetry: onRetry,
    );
  }
}

/// Error view untuk server error
class SpaceServerError extends StatelessWidget {
  final VoidCallback? onRetry;

  const SpaceServerError({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SpaceErrorView(
      icon: Icons.cloud_off_outlined,
      title: 'Terjadi Kesalahan',
      message:
          'Server sedang mengalami masalah.\nCoba lagi dalam beberapa saat.',
      retryText: onRetry != null ? 'Coba Lagi' : null,
      onRetry: onRetry,
    );
  }
}

/// Error view untuk session expired
class SpaceSessionExpired extends StatelessWidget {
  final VoidCallback? onLogin;

  const SpaceSessionExpired({super.key, this.onLogin});

  @override
  Widget build(BuildContext context) {
    return SpaceErrorView(
      icon: Icons.timer_off_outlined,
      title: 'Sesi Berakhir',
      message: 'Sesi Anda telah berakhir.\nSilakan login kembali.',
      retryText: onLogin != null ? 'Login Kembali' : null,
      onRetry: onLogin,
    );
  }
}

/// Error view untuk not found (404)
class SpaceNotFoundError extends StatelessWidget {
  final String? itemName;
  final VoidCallback? onGoBack;

  const SpaceNotFoundError({super.key, this.itemName, this.onGoBack});

  @override
  Widget build(BuildContext context) {
    return SpaceErrorView(
      icon: Icons.search_off_outlined,
      title: 'Tidak Ditemukan',
      message: itemName != null
          ? '$itemName tidak ditemukan.'
          : 'Halaman yang Anda cari\ntidak ditemukan.',
      retryText: onGoBack != null ? 'Kembali' : null,
      onRetry: onGoBack,
    );
  }
}

/// Error view untuk permission denied
class SpacePermissionDenied extends StatelessWidget {
  final VoidCallback? onGoBack;

  const SpacePermissionDenied({super.key, this.onGoBack});

  @override
  Widget build(BuildContext context) {
    return SpaceErrorView(
      icon: Icons.lock_outline,
      title: 'Akses Ditolak',
      message: 'Anda tidak memiliki izin\nuntuk mengakses halaman ini.',
      retryText: onGoBack != null ? 'Kembali' : null,
      onRetry: onGoBack,
    );
  }
}

/// Error snackbar helper
class SpaceErrorSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onRetry,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: SpaceColors.error,
              size: SpaceDimensions.iconMd,
            ),
            const SizedBox(width: SpaceDimensions.spacing12),
            Expanded(child: Text(message, style: SpaceTextStyles.bodyMedium)),
          ],
        ),
        action: onRetry != null
            ? SnackBarAction(label: 'Coba Lagi', onPressed: onRetry)
            : null,
        duration: duration,
        backgroundColor: SpaceColors.surface,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
