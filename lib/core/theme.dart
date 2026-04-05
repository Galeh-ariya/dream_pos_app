import 'package:flutter/material.dart';
import 'colors.dart';

/// App Theme Configuration
///
/// Implements "The Fluid Precision Framework" Design System with:
/// - High-End Editorial aesthetic
/// - Tonal layering instead of shadows
/// - Glassmorphism for floating elements
/// - Inter typography (Swiss-inspired)
class AppTheme {
  AppTheme._();

  /// Light theme for the application
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.materialColorScheme,
      scaffoldBackgroundColor: AppColors.surface,

      // Typography - Inter font assumed to be available in pubspec.yaml
      textTheme: _buildTextTheme(),

      // App Bar
      appBarTheme: AppBarThemeData(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.onSurface,
        elevation: 0,
        centerTitle: false,
      ),

      // Primary button (elevated/filled)
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.xl),
          ),
          elevation: 0,
        ),
      ),

      // Outlined button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: AppColors.outlineVariant.withOpacity(0.3)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.xl),
          ),
        ),
      ),

      // Text button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),

      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainerHigh,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: BorderSide(
            color: AppColors.primary.withOpacity(0.5),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintStyle: TextStyle(color: AppColors.onSurfaceVariant),
        labelStyle: TextStyle(color: AppColors.onSurface),
      ),

      // Card theme
      cardTheme: CardThemeData(
        color: AppColors.surfaceContainerLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
        margin: EdgeInsets.zero,
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.full),
        ),
        selectedColor: AppColors.primaryContainer,
        backgroundColor: AppColors.surfaceContainerHighest,
        labelStyle: const TextStyle(color: AppColors.onSurface),
        secondaryLabelStyle: const TextStyle(color: AppColors.onSurface),
      ),

      // List tile
      listTileTheme: ListTileThemeData(
        tileColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
      ),

      // Dividers removed per design system (no-line rule)
      dividerTheme: DividerThemeData(
        color: Colors.transparent,
        space: AppSpacing.verticalSpacing,
      ),

      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceContainerLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
        ),
      ),

      // Bottom sheet theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surface.withOpacity(0.95),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppRadii.lg),
            topRight: Radius.circular(AppRadii.lg),
          ),
        ),
      ),
    );
  }

  /// Build text theme aligned with "Inter Editorial Scale"
  static TextTheme _buildTextTheme() {
    return TextTheme(
      // Display styles
      displayLarge: TextStyle(
        fontSize: 56, // 3.5rem
        fontWeight: FontWeight.w600,
        letterSpacing: -0.02,
        color: AppColors.onSurface,
        fontFamily: 'Inter',
      ),
      displayMedium: TextStyle(
        fontSize: 44,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.02,
        color: AppColors.onSurface,
        fontFamily: 'Inter',
      ),
      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.02,
        color: AppColors.onSurface,
        fontFamily: 'Inter',
      ),

      // Headline styles
      headlineLarge: TextStyle(
        fontSize: 32, // 2rem
        fontWeight: FontWeight.w700,
        letterSpacing: -0.02,
        color: AppColors.onSurface,
        fontFamily: 'Inter',
      ),
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.onSurface,
        fontFamily: 'Inter',
      ),
      headlineSmall: TextStyle(
        fontSize: 24, // 1.5rem
        fontWeight: FontWeight.w700,
        color: AppColors.onSurface,
        fontFamily: 'Inter',
      ),

      // Title styles
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.onSurface,
        fontFamily: 'Inter',
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        color: AppColors.onSurface,
        fontFamily: 'Inter',
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: AppColors.onSurface,
        fontFamily: 'Inter',
      ),

      // Body styles - body-lg is the workhorse
      bodyLarge: TextStyle(
        fontSize: 16, // 1rem
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.6, // Generous line-height for legibility
        color: AppColors.onSurface,
        fontFamily: 'Inter',
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.6,
        color: AppColors.onSurface,
        fontFamily: 'Inter',
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.6,
        color: AppColors.onSurfaceVariant,
        fontFamily: 'Inter',
      ),

      // Label styles
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: AppColors.onSurface,
        fontFamily: 'Inter',
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: AppColors.onSurface,
        fontFamily: 'Inter',
      ),
      labelSmall: TextStyle(
        fontSize: 11, // 0.6875rem
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: AppColors.primary,
        fontFamily: 'Inter',
      ),
    );
  }
}
