import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'space_colors.dart';
import 'space_text_styles.dart';
import 'space_dimensions.dart';

/// UIMSpace Light Theme
/// Tema alternatif light mode (optional, jika dibutuhkan)
/// Tetap mempertahankan identitas Space Learning
class SpaceLightTheme {
  SpaceLightTheme._();

  // Light mode color palette
  static const Color _backgroundLight = Color(0xFFF8FAFC);
  static const Color _surfaceLight = Color(0xFFFFFFFF);
  static const Color _surfaceVariantLight = Color(0xFFF1F5F9);
  static const Color _textPrimaryLight = Color(0xFF0F172A);
  static const Color _textSecondaryLight = Color(0xFF64748B);
  static const Color _borderLight = Color(0xFFE2E8F0);
  static const Color _dividerLight = Color(0xFFE2E8F0);

  /// Get the light theme data
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // ============================================
      // COLOR SCHEME
      // ============================================
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: SpaceColors.primary,
        onPrimary: SpaceColors.textOnPrimary,
        primaryContainer: SpaceColors.primaryLight,
        onPrimaryContainer: SpaceColors.textOnPrimary,
        secondary: SpaceColors.secondaryDark,
        onSecondary: SpaceColors.textOnPrimary,
        secondaryContainer: SpaceColors.secondaryLight,
        onSecondaryContainer: _textPrimaryLight,
        error: SpaceColors.error,
        onError: SpaceColors.textOnPrimary,
        errorContainer: SpaceColors.errorLight,
        onErrorContainer: SpaceColors.textOnPrimary,
        surface: _surfaceLight,
        onSurface: _textPrimaryLight,
        surfaceContainerHighest: _surfaceVariantLight,
        onSurfaceVariant: _textSecondaryLight,
        outline: _borderLight,
        outlineVariant: _dividerLight,
        shadow: SpaceColors.shadow,
        scrim: SpaceColors.overlay,
      ),

      // ============================================
      // SCAFFOLD BACKGROUND
      // ============================================
      scaffoldBackgroundColor: _backgroundLight,

      // ============================================
      // APPBAR THEME
      // ============================================
      appBarTheme: AppBarTheme(
        backgroundColor: _backgroundLight,
        foregroundColor: _textPrimaryLight,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: true,
        titleTextStyle: SpaceTextStyles.titleLarge.copyWith(
          color: _textPrimaryLight,
        ),
        iconTheme: const IconThemeData(
          color: _textPrimaryLight,
          size: SpaceDimensions.iconLg,
        ),
        actionsIconTheme: const IconThemeData(
          color: _textPrimaryLight,
          size: SpaceDimensions.iconLg,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: _backgroundLight,
        ),
      ),

      // ============================================
      // BOTTOM NAVIGATION BAR THEME
      // ============================================
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: _surfaceLight,
        selectedItemColor: SpaceColors.primary,
        unselectedItemColor: _textSecondaryLight,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: SpaceTextStyles.labelSmall.copyWith(
          color: SpaceColors.primary,
        ),
        unselectedLabelStyle: SpaceTextStyles.labelSmall.copyWith(
          color: _textSecondaryLight,
        ),
      ),

      // ============================================
      // NAVIGATION BAR THEME (Material 3)
      // ============================================
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: _surfaceLight,
        indicatorColor: SpaceColors.primaryWithOpacity(0.15),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: SpaceColors.primary,
              size: SpaceDimensions.iconLg,
            );
          }
          return IconThemeData(
            color: _textSecondaryLight,
            size: SpaceDimensions.iconLg,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return SpaceTextStyles.labelSmall.copyWith(
              color: SpaceColors.primary,
            );
          }
          return SpaceTextStyles.labelSmall.copyWith(
            color: _textSecondaryLight,
          );
        }),
        height: SpaceDimensions.bottomNavHeight,
        elevation: 4,
      ),

      // ============================================
      // CARD THEME
      // ============================================
      cardTheme: CardThemeData(
        color: _surfaceLight,
        elevation: SpaceDimensions.elevationSm,
        shadowColor: SpaceColors.shadow,
        shape: RoundedRectangleBorder(borderRadius: SpaceDimensions.cardRadius),
        margin: EdgeInsets.zero,
      ),

      // ============================================
      // ELEVATED BUTTON THEME
      // ============================================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: SpaceColors.primary,
          foregroundColor: SpaceColors.textOnPrimary,
          disabledBackgroundColor: SpaceColors.primaryWithOpacity(
            SpaceColors.disabledOpacity,
          ),
          disabledForegroundColor: SpaceColors.textOnPrimary.withValues(
            alpha: SpaceColors.disabledOpacity,
          ),
          elevation: SpaceDimensions.elevationSm,
          padding: SpaceDimensions.buttonPadding,
          minimumSize: const Size(88, SpaceDimensions.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: SpaceDimensions.buttonRadius,
          ),
          textStyle: SpaceTextStyles.labelLarge,
        ),
      ),

      // ============================================
      // TEXT BUTTON THEME
      // ============================================
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: SpaceColors.primary,
          disabledForegroundColor: SpaceColors.primaryWithOpacity(
            SpaceColors.disabledOpacity,
          ),
          padding: SpaceDimensions.buttonPadding,
          minimumSize: const Size(64, SpaceDimensions.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: SpaceDimensions.buttonRadius,
          ),
          textStyle: SpaceTextStyles.labelLarge,
        ),
      ),

      // ============================================
      // OUTLINED BUTTON THEME
      // ============================================
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: SpaceColors.primary,
          disabledForegroundColor: SpaceColors.primaryWithOpacity(
            SpaceColors.disabledOpacity,
          ),
          side: const BorderSide(color: SpaceColors.primary, width: 1),
          padding: SpaceDimensions.buttonPadding,
          minimumSize: const Size(88, SpaceDimensions.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: SpaceDimensions.buttonRadius,
          ),
          textStyle: SpaceTextStyles.labelLarge,
        ),
      ),

      // ============================================
      // INPUT DECORATION THEME
      // ============================================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _surfaceVariantLight,
        hintStyle: SpaceTextStyles.bodyMedium.copyWith(
          color: _textSecondaryLight,
        ),
        labelStyle: SpaceTextStyles.bodyMedium.copyWith(
          color: _textSecondaryLight,
        ),
        floatingLabelStyle: SpaceTextStyles.labelMedium.copyWith(
          color: SpaceColors.primary,
        ),
        errorStyle: SpaceTextStyles.labelSmall.copyWith(
          color: SpaceColors.error,
        ),
        contentPadding: SpaceDimensions.inputPadding,
        border: OutlineInputBorder(
          borderRadius: SpaceDimensions.inputRadius,
          borderSide: const BorderSide(color: _borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: SpaceDimensions.inputRadius,
          borderSide: const BorderSide(color: _borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: SpaceDimensions.inputRadius,
          borderSide: const BorderSide(color: SpaceColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: SpaceDimensions.inputRadius,
          borderSide: const BorderSide(color: SpaceColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: SpaceDimensions.inputRadius,
          borderSide: const BorderSide(color: SpaceColors.error, width: 2),
        ),
      ),

      // ============================================
      // DIALOG THEME
      // ============================================
      dialogTheme: DialogThemeData(
        backgroundColor: _surfaceLight,
        elevation: SpaceDimensions.elevationXl,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SpaceDimensions.radiusLg),
        ),
        titleTextStyle: SpaceTextStyles.headlineSmall.copyWith(
          color: _textPrimaryLight,
        ),
        contentTextStyle: SpaceTextStyles.bodyMedium.copyWith(
          color: _textPrimaryLight,
        ),
      ),

      // ============================================
      // DIVIDER THEME
      // ============================================
      dividerTheme: const DividerThemeData(
        color: _dividerLight,
        thickness: 1,
        space: 1,
      ),

      // ============================================
      // TEXT THEME
      // ============================================
      textTheme: TextTheme(
        displayLarge: SpaceTextStyles.displayLarge.copyWith(
          color: _textPrimaryLight,
        ),
        displayMedium: SpaceTextStyles.displayMedium.copyWith(
          color: _textPrimaryLight,
        ),
        displaySmall: SpaceTextStyles.displaySmall.copyWith(
          color: _textPrimaryLight,
        ),
        headlineLarge: SpaceTextStyles.headlineLarge.copyWith(
          color: _textPrimaryLight,
        ),
        headlineMedium: SpaceTextStyles.headlineMedium.copyWith(
          color: _textPrimaryLight,
        ),
        headlineSmall: SpaceTextStyles.headlineSmall.copyWith(
          color: _textPrimaryLight,
        ),
        titleLarge: SpaceTextStyles.titleLarge.copyWith(
          color: _textPrimaryLight,
        ),
        titleMedium: SpaceTextStyles.titleMedium.copyWith(
          color: _textPrimaryLight,
        ),
        titleSmall: SpaceTextStyles.titleSmall.copyWith(
          color: _textPrimaryLight,
        ),
        bodyLarge: SpaceTextStyles.bodyLarge.copyWith(color: _textPrimaryLight),
        bodyMedium: SpaceTextStyles.bodyMedium.copyWith(
          color: _textPrimaryLight,
        ),
        bodySmall: SpaceTextStyles.bodySmall.copyWith(
          color: _textSecondaryLight,
        ),
        labelLarge: SpaceTextStyles.labelLarge.copyWith(
          color: _textPrimaryLight,
        ),
        labelMedium: SpaceTextStyles.labelMedium.copyWith(
          color: _textPrimaryLight,
        ),
        labelSmall: SpaceTextStyles.labelSmall.copyWith(
          color: _textSecondaryLight,
        ),
      ),
    );
  }
}
