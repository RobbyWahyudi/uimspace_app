import 'package:flutter/material.dart';
import 'space_colors.dart';

/// UIMSpace Text Styles
/// Typography system untuk tema Space Learning
class SpaceTextStyles {
  SpaceTextStyles._();

  // ============================================
  // FONT FAMILY
  // ============================================

  /// Default font family (menggunakan system font)
  /// Bisa diganti dengan Google Fonts seperti Inter, Roboto, dll
  static const String fontFamily = 'Roboto';

  // ============================================
  // DISPLAY STYLES (untuk heading besar)
  // ============================================

  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
    color: SpaceColors.textPrimary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 45,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.16,
    color: SpaceColors.textPrimary,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.22,
    color: SpaceColors.textPrimary,
  );

  // ============================================
  // HEADLINE STYLES (untuk section titles)
  // ============================================

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.25,
    color: SpaceColors.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.29,
    color: SpaceColors.textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.33,
    color: SpaceColors.textPrimary,
  );

  // ============================================
  // TITLE STYLES (untuk card titles, appbar, dll)
  // ============================================

  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    height: 1.27,
    color: SpaceColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.50,
    color: SpaceColors.textPrimary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
    color: SpaceColors.textPrimary,
  );

  // ============================================
  // BODY STYLES (untuk konten utama)
  // ============================================

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.50,
    color: SpaceColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
    color: SpaceColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
    color: SpaceColors.textSecondary,
  );

  // ============================================
  // LABEL STYLES (untuk button, caption, dll)
  // ============================================

  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
    color: SpaceColors.textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
    color: SpaceColors.textPrimary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
    color: SpaceColors.textSecondary,
  );

  // ============================================
  // CUSTOM STYLES untuk LMS
  // ============================================

  /// Style untuk nama mata kuliah
  static const TextStyle courseName = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.33,
    color: SpaceColors.textPrimary,
  );

  /// Style untuk deadline
  static const TextStyle deadline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.4,
    height: 1.33,
    color: SpaceColors.warning,
  );

  /// Style untuk grade/nilai
  static const TextStyle grade = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.2,
    color: SpaceColors.secondary,
  );

  /// Style untuk badge/chip
  static const TextStyle badge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.2,
    color: SpaceColors.textOnPrimary,
  );

  /// Style untuk link
  static const TextStyle link = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.25,
    height: 1.43,
    color: SpaceColors.primary,
    decoration: TextDecoration.underline,
    decorationColor: SpaceColors.primary,
  );

  // ============================================
  // HELPER METHODS
  // ============================================

  /// Get text style with custom color
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Get text style with secondary color
  static TextStyle asSecondary(TextStyle style) {
    return style.copyWith(color: SpaceColors.textSecondary);
  }

  /// Get text style with error color
  static TextStyle asError(TextStyle style) {
    return style.copyWith(color: SpaceColors.error);
  }

  /// Get text style with success color
  static TextStyle asSuccess(TextStyle style) {
    return style.copyWith(color: SpaceColors.success);
  }
}
