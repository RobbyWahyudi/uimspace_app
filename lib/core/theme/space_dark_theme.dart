import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'space_colors.dart';
import 'space_text_styles.dart';
import 'space_dimensions.dart';

/// UIMSpace Dark Theme
/// Tema utama untuk aplikasi dengan konsep "Space Learning"
class SpaceDarkTheme {
  SpaceDarkTheme._();

  /// Get the dark theme data
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // ============================================
      // COLOR SCHEME
      // ============================================
      colorScheme: const ColorScheme.dark(
        brightness: Brightness.dark,
        primary: SpaceColors.primary,
        onPrimary: SpaceColors.textOnPrimary,
        primaryContainer: SpaceColors.primaryDark,
        onPrimaryContainer: SpaceColors.textOnPrimary,
        secondary: SpaceColors.secondary,
        onSecondary: SpaceColors.textOnSecondary,
        secondaryContainer: SpaceColors.secondaryDark,
        onSecondaryContainer: SpaceColors.textOnPrimary,
        error: SpaceColors.error,
        onError: SpaceColors.textOnPrimary,
        errorContainer: SpaceColors.errorDark,
        onErrorContainer: SpaceColors.textOnPrimary,
        surface: SpaceColors.surface,
        onSurface: SpaceColors.textPrimary,
        surfaceContainerHighest: SpaceColors.surfaceVariant,
        onSurfaceVariant: SpaceColors.textSecondary,
        outline: SpaceColors.border,
        outlineVariant: SpaceColors.divider,
        shadow: SpaceColors.shadow,
        scrim: SpaceColors.overlay,
      ),

      // ============================================
      // SCAFFOLD BACKGROUND
      // ============================================
      scaffoldBackgroundColor: SpaceColors.background,

      // ============================================
      // APPBAR THEME
      // ============================================
      appBarTheme: AppBarTheme(
        backgroundColor: SpaceColors.background,
        foregroundColor: SpaceColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: SpaceTextStyles.titleLarge,
        iconTheme: const IconThemeData(
          color: SpaceColors.textPrimary,
          size: SpaceDimensions.iconLg,
        ),
        actionsIconTheme: const IconThemeData(
          color: SpaceColors.textPrimary,
          size: SpaceDimensions.iconLg,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: SpaceColors.background,
        ),
      ),

      // ============================================
      // BOTTOM NAVIGATION BAR THEME
      // ============================================
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: SpaceColors.surface,
        selectedItemColor: SpaceColors.primary,
        unselectedItemColor: SpaceColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: SpaceTextStyles.labelSmall,
        unselectedLabelStyle: SpaceTextStyles.labelSmall,
      ),

      // ============================================
      // NAVIGATION BAR THEME (Material 3)
      // ============================================
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: SpaceColors.surface,
        indicatorColor: SpaceColors.primaryWithOpacity(0.2),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: SpaceColors.primary,
              size: SpaceDimensions.iconLg,
            );
          }
          return const IconThemeData(
            color: SpaceColors.textSecondary,
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
            color: SpaceColors.textSecondary,
          );
        }),
        height: SpaceDimensions.bottomNavHeight,
        elevation: 0,
      ),

      // ============================================
      // CARD THEME
      // ============================================
      cardTheme: CardThemeData(
        color: SpaceColors.surface,
        elevation: SpaceDimensions.elevationNone,
        shape: RoundedRectangleBorder(
          borderRadius: SpaceDimensions.cardRadius,
          side: const BorderSide(color: SpaceColors.border, width: 1),
        ),
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
          elevation: 0,
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
      // ICON BUTTON THEME
      // ============================================
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: SpaceColors.textPrimary,
          disabledForegroundColor: SpaceColors.textDisabled,
          iconSize: SpaceDimensions.iconLg,
        ),
      ),

      // ============================================
      // FLOATING ACTION BUTTON THEME
      // ============================================
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: SpaceColors.primary,
        foregroundColor: SpaceColors.textOnPrimary,
        elevation: SpaceDimensions.elevationMd,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SpaceDimensions.radiusMd),
        ),
      ),

      // ============================================
      // INPUT DECORATION THEME
      // ============================================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: SpaceColors.surfaceVariant,
        hintStyle: SpaceTextStyles.bodyMedium.copyWith(
          color: SpaceColors.textSecondary,
        ),
        labelStyle: SpaceTextStyles.bodyMedium.copyWith(
          color: SpaceColors.textSecondary,
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
          borderSide: const BorderSide(color: SpaceColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: SpaceDimensions.inputRadius,
          borderSide: const BorderSide(color: SpaceColors.border),
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
        disabledBorder: OutlineInputBorder(
          borderRadius: SpaceDimensions.inputRadius,
          borderSide: BorderSide(
            color: SpaceColors.border.withValues(
              alpha: SpaceColors.disabledOpacity,
            ),
          ),
        ),
      ),

      // ============================================
      // CHIP THEME
      // ============================================
      chipTheme: ChipThemeData(
        backgroundColor: SpaceColors.surfaceVariant,
        selectedColor: SpaceColors.primary,
        disabledColor: SpaceColors.surfaceVariant.withValues(
          alpha: SpaceColors.disabledOpacity,
        ),
        labelStyle: SpaceTextStyles.labelMedium,
        secondaryLabelStyle: SpaceTextStyles.labelMedium.copyWith(
          color: SpaceColors.textOnPrimary,
        ),
        padding: SpaceDimensions.chipPadding,
        shape: RoundedRectangleBorder(
          borderRadius: SpaceDimensions.chipRadius,
          side: const BorderSide(color: SpaceColors.border),
        ),
      ),

      // ============================================
      // DIALOG THEME
      // ============================================
      dialogTheme: DialogThemeData(
        backgroundColor: SpaceColors.surface,
        elevation: SpaceDimensions.elevationLg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SpaceDimensions.radiusLg),
        ),
        titleTextStyle: SpaceTextStyles.headlineSmall,
        contentTextStyle: SpaceTextStyles.bodyMedium,
      ),

      // ============================================
      // BOTTOM SHEET THEME
      // ============================================
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: SpaceColors.surface,
        elevation: SpaceDimensions.elevationLg,
        shape: RoundedRectangleBorder(
          borderRadius: SpaceDimensions.bottomSheetRadius,
        ),
        dragHandleColor: SpaceColors.textSecondary,
        dragHandleSize: Size(32, 4),
        showDragHandle: true,
      ),

      // ============================================
      // SNACKBAR THEME
      // ============================================
      snackBarTheme: SnackBarThemeData(
        backgroundColor: SpaceColors.surfaceVariant,
        contentTextStyle: SpaceTextStyles.bodyMedium,
        actionTextColor: SpaceColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SpaceDimensions.radiusSm),
        ),
      ),

      // ============================================
      // PROGRESS INDICATOR THEME
      // ============================================
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: SpaceColors.primary,
        linearTrackColor: SpaceColors.surfaceVariant,
        circularTrackColor: SpaceColors.surfaceVariant,
      ),

      // ============================================
      // DIVIDER THEME
      // ============================================
      dividerTheme: const DividerThemeData(
        color: SpaceColors.divider,
        thickness: 1,
        space: 1,
      ),

      // ============================================
      // LIST TILE THEME
      // ============================================
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
        iconColor: SpaceColors.textSecondary,
        textColor: SpaceColors.textPrimary,
        contentPadding: SpaceDimensions.listItemPadding,
        minVerticalPadding: SpaceDimensions.spacing8,
        shape: RoundedRectangleBorder(borderRadius: SpaceDimensions.cardRadius),
      ),

      // ============================================
      // TAB BAR THEME
      // ============================================
      tabBarTheme: TabBarThemeData(
        labelColor: SpaceColors.primary,
        unselectedLabelColor: SpaceColors.textSecondary,
        labelStyle: SpaceTextStyles.labelLarge,
        unselectedLabelStyle: SpaceTextStyles.labelLarge,
        indicatorColor: SpaceColors.primary,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: SpaceColors.divider,
      ),

      // ============================================
      // SWITCH THEME
      // ============================================
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return SpaceColors.primary;
          }
          return SpaceColors.textSecondary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return SpaceColors.primaryWithOpacity(0.5);
          }
          return SpaceColors.surfaceVariant;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // ============================================
      // CHECKBOX THEME
      // ============================================
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return SpaceColors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(SpaceColors.textOnPrimary),
        side: const BorderSide(color: SpaceColors.border, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SpaceDimensions.radiusXs),
        ),
      ),

      // ============================================
      // RADIO THEME
      // ============================================
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return SpaceColors.primary;
          }
          return SpaceColors.textSecondary;
        }),
      ),

      // ============================================
      // TOOLTIP THEME
      // ============================================
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: SpaceColors.surfaceVariant,
          borderRadius: BorderRadius.circular(SpaceDimensions.radiusSm),
        ),
        textStyle: SpaceTextStyles.bodySmall.copyWith(
          color: SpaceColors.textPrimary,
        ),
      ),

      // ============================================
      // TEXT THEME
      // ============================================
      textTheme: const TextTheme(
        displayLarge: SpaceTextStyles.displayLarge,
        displayMedium: SpaceTextStyles.displayMedium,
        displaySmall: SpaceTextStyles.displaySmall,
        headlineLarge: SpaceTextStyles.headlineLarge,
        headlineMedium: SpaceTextStyles.headlineMedium,
        headlineSmall: SpaceTextStyles.headlineSmall,
        titleLarge: SpaceTextStyles.titleLarge,
        titleMedium: SpaceTextStyles.titleMedium,
        titleSmall: SpaceTextStyles.titleSmall,
        bodyLarge: SpaceTextStyles.bodyLarge,
        bodyMedium: SpaceTextStyles.bodyMedium,
        bodySmall: SpaceTextStyles.bodySmall,
        labelLarge: SpaceTextStyles.labelLarge,
        labelMedium: SpaceTextStyles.labelMedium,
        labelSmall: SpaceTextStyles.labelSmall,
      ),
    );
  }
}
