import 'package:flutter/material.dart';

/// UIMSpace Dimensions & Spacing
/// Sistem spacing dan sizing yang konsisten
class SpaceDimensions {
  SpaceDimensions._();

  // ============================================
  // SPACING (menggunakan kelipatan 4)
  // ============================================

  static const double spacing0 = 0;
  static const double spacing2 = 2;
  static const double spacing4 = 4;
  static const double spacing6 = 6;
  static const double spacing8 = 8;
  static const double spacing10 = 10;
  static const double spacing12 = 12;
  static const double spacing16 = 16;
  static const double spacing20 = 20;
  static const double spacing24 = 24;
  static const double spacing32 = 32;
  static const double spacing40 = 40;
  static const double spacing48 = 48;
  static const double spacing56 = 56;
  static const double spacing64 = 64;
  static const double spacing80 = 80;

  // ============================================
  // PADDING PRESETS
  // ============================================

  /// Padding untuk screen
  static const EdgeInsets screenPadding = EdgeInsets.all(spacing16);

  /// Padding horizontal screen
  static const EdgeInsets screenPaddingHorizontal = EdgeInsets.symmetric(
    horizontal: spacing16,
  );

  /// Padding untuk card content
  static const EdgeInsets cardPadding = EdgeInsets.all(spacing16);

  /// Padding untuk card yang compact
  static const EdgeInsets cardPaddingCompact = EdgeInsets.all(spacing12);

  /// Padding untuk list item
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    horizontal: spacing16,
    vertical: spacing12,
  );

  /// Padding untuk button
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: spacing24,
    vertical: spacing12,
  );

  /// Padding untuk button small
  static const EdgeInsets buttonPaddingSmall = EdgeInsets.symmetric(
    horizontal: spacing16,
    vertical: spacing8,
  );

  /// Padding untuk chip/badge
  static const EdgeInsets chipPadding = EdgeInsets.symmetric(
    horizontal: spacing12,
    vertical: spacing6,
  );

  /// Padding untuk input field
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: spacing16,
    vertical: spacing12,
  );

  // ============================================
  // BORDER RADIUS
  // ============================================

  static const double radiusNone = 0;
  static const double radiusXs = 4;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 20;
  static const double radius2xl = 24;
  static const double radiusFull = 999;

  /// Border radius untuk card
  static const BorderRadius cardRadius = BorderRadius.all(
    Radius.circular(radiusMd),
  );

  /// Border radius untuk button
  static const BorderRadius buttonRadius = BorderRadius.all(
    Radius.circular(radiusSm),
  );

  /// Border radius untuk chip/badge
  static const BorderRadius chipRadius = BorderRadius.all(
    Radius.circular(radiusFull),
  );

  /// Border radius untuk input field
  static const BorderRadius inputRadius = BorderRadius.all(
    Radius.circular(radiusSm),
  );

  /// Border radius untuk bottom sheet
  static const BorderRadius bottomSheetRadius = BorderRadius.only(
    topLeft: Radius.circular(radiusXl),
    topRight: Radius.circular(radiusXl),
  );

  /// Border radius untuk avatar
  static const BorderRadius avatarRadius = BorderRadius.all(
    Radius.circular(radiusFull),
  );

  // ============================================
  // ICON SIZES
  // ============================================

  static const double iconXs = 12;
  static const double iconSm = 16;
  static const double iconMd = 20;
  static const double iconLg = 24;
  static const double iconXl = 32;
  static const double icon2xl = 40;
  static const double icon3xl = 48;

  // ============================================
  // AVATAR SIZES
  // ============================================

  static const double avatarSm = 32;
  static const double avatarMd = 40;
  static const double avatarLg = 48;
  static const double avatarXl = 64;
  static const double avatar2xl = 80;
  static const double avatar3xl = 120;

  // ============================================
  // COMPONENT HEIGHTS
  // ============================================

  static const double buttonHeight = 48;
  static const double buttonHeightSmall = 36;
  static const double buttonHeightLarge = 56;

  static const double inputHeight = 48;
  static const double inputHeightSmall = 40;

  static const double appBarHeight = 56;
  static const double bottomNavHeight = 64;

  static const double cardMinHeight = 80;
  static const double listItemHeight = 64;

  // ============================================
  // ELEVATION (untuk shadow)
  // ============================================

  static const double elevationNone = 0;
  static const double elevationSm = 2;
  static const double elevationMd = 4;
  static const double elevationLg = 8;
  static const double elevationXl = 16;

  // ============================================
  // ANIMATION DURATIONS
  // ============================================

  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 250);
  static const Duration durationSlow = Duration(milliseconds: 350);
  static const Duration durationVerySlow = Duration(milliseconds: 500);

  // ============================================
  // ANIMATION CURVES
  // ============================================

  static const Curve curveDefault = Curves.easeInOut;
  static const Curve curveEmphasized = Curves.easeOutCubic;
  static const Curve curveDecelerate = Curves.decelerate;
}
