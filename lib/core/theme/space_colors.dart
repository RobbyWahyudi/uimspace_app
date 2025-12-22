import 'package:flutter/material.dart';

/// UIMSpace Color Palette
/// Tema: Space Learning
/// Konsep: Fokus, modern, akademik, futuristik ringan
class SpaceColors {
  SpaceColors._();

  // ============================================
  // CORE COLORS
  // ============================================

  /// Background utama - Space Navy
  static const Color background = Color(0xFF0B1220);

  /// Surface / Card - Dark Slate
  static const Color surface = Color(0xFF111827);

  /// Surface variant untuk variasi card/container
  static const Color surfaceVariant = Color(0xFF1F2937);

  /// Primary (aksi utama) - Space Blue
  static const Color primary = Color(0xFF2563EB);

  /// Primary dengan opacity untuk hover/pressed state
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1D4ED8);

  /// Secondary / Accent - Cyan Glow
  static const Color secondary = Color(0xFF22D3EE);

  /// Secondary variants
  static const Color secondaryLight = Color(0xFF67E8F9);
  static const Color secondaryDark = Color(0xFF06B6D4);

  // ============================================
  // TEXT COLORS
  // ============================================

  /// Text utama - Soft White
  static const Color textPrimary = Color(0xFFE5E7EB);

  /// Text sekunder - Muted Gray
  static const Color textSecondary = Color(0xFF9CA3AF);

  /// Text disabled
  static const Color textDisabled = Color(0xFF6B7280);

  /// Text on primary (untuk button, dll)
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  /// Text on secondary
  static const Color textOnSecondary = Color(0xFF0B1220);

  // ============================================
  // STATUS COLORS
  // ============================================

  /// Success (tugas terkumpul) - Green
  static const Color success = Color(0xFF22C55E);
  static const Color successLight = Color(0xFF4ADE80);
  static const Color successDark = Color(0xFF16A34A);

  /// Warning (deadline dekat) - Yellow
  static const Color warning = Color(0xFFFACC15);
  static const Color warningLight = Color(0xFFFDE047);
  static const Color warningDark = Color(0xFFEAB308);

  /// Error (gagal submit) - Red
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);

  /// Info (pengumuman) - Sky Blue
  static const Color info = Color(0xFF38BDF8);
  static const Color infoLight = Color(0xFF7DD3FC);
  static const Color infoDark = Color(0xFF0EA5E9);

  // ============================================
  // DIVIDER & BORDER
  // ============================================

  /// Divider color
  static const Color divider = Color(0xFF374151);

  /// Border color
  static const Color border = Color(0xFF374151);

  /// Border focus state
  static const Color borderFocus = Color(0xFF2563EB);

  // ============================================
  // OVERLAY & SHADOW
  // ============================================

  /// Overlay untuk modal/dialog
  static const Color overlay = Color(0x80000000);

  /// Shadow color
  static const Color shadow = Color(0x40000000);

  // ============================================
  // GRADIENT COLORS
  // ============================================

  /// Primary gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
  );

  /// Background gradient (subtle)
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF0F172A), background],
  );

  /// Card glow effect gradient
  static const RadialGradient glowGradient = RadialGradient(
    colors: [Color(0x1A22D3EE), Color(0x00000000)],
    radius: 1.5,
  );

  // ============================================
  // OPACITY HELPERS (untuk hover/active state)
  // ============================================

  /// Opacity untuk hover state
  static const double hoverOpacity = 0.08;

  /// Opacity untuk pressed/active state
  static const double pressedOpacity = 0.12;

  /// Opacity untuk disabled state
  static const double disabledOpacity = 0.38;

  /// Opacity untuk focus state
  static const double focusOpacity = 0.12;

  // ============================================
  // COLOR WITH OPACITY HELPERS
  // ============================================

  static Color primaryWithOpacity(double opacity) =>
      primary.withValues(alpha: opacity);

  static Color secondaryWithOpacity(double opacity) =>
      secondary.withValues(alpha: opacity);

  static Color surfaceWithOpacity(double opacity) =>
      surface.withValues(alpha: opacity);
}
