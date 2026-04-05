import 'package:flutter/material.dart';

/// App Color Palette
/// Based on "The Fluid Precision Framework" Design System
///
/// This palette follows the "High-End Editorial" approach with:
/// - Deep authoritative blue as primary
/// - Expansive atmospheric neutrals
/// - Tonal stacking for surface hierarchy
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  /// Primary color - Deep authoritative blue
  static const Color primary = Color(0xFF005bc4);

  /// Primary container - Lighter blue for backgrounds and CTAs
  static const Color primaryContainer = Color(0xFF4388fd);

  /// Surface colors - Base layer for UI
  static const Color surface = Color(0xFFfaf9fe);

  /// Surface container low - Receded sections background
  static const Color surfaceContainerLow = Color(0xFFf3f3fa);

  /// Surface container lowest - Active elements/Cards (White)
  static const Color surfaceContainerLowest = Color(0xFFffffff);

  /// Surface container high - For input fields and slightly elevated surfaces
  static const Color surfaceContainerHigh = Color(0xFFeCeCf7);

  /// Surface container highest - High-impact overlays
  static const Color surfaceContainerHighest = Color(0xFFe0e2ed);

  /// On surface - Primary text color (not pure black)
  static const Color onSurface = Color(0xFF2f323a);

  /// On surface variant - Secondary information text
  static const Color onSurfaceVariant = Color(0xFF5c5f68);

  /// Outline variant - Ghost borders at 15% opacity
  static const Color outlineVariant = Color(0xFFafb1bc);

  /// Surface tint - For soft glow effects and glassmorphism
  static const Color surfaceTint = primary;

  // Helper: Return color with custom opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  // Preset opacity values for design system compliance

  /// Ghost border opacity (15%)
  static Color get ghostBorder => outlineVariant.withOpacity(0.15);

  /// Cloud shadow color with 6% opacity for floating elements
  static Color get cloudShadow => onSurface.withOpacity(0.06);

  /// Glassmorphism container at 80% opacity
  static Color get glassmorphismContainer => surface.withOpacity(0.80);

  /// Outline at 20% opacity for input focus states
  static Color get outlineFocused => outlineVariant.withOpacity(0.20);

  // Material 3 ColorScheme based on design system
  static ColorScheme get materialColorScheme {
    return ColorScheme.light(
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: primaryContainer,
      onPrimaryContainer: Colors.white,
      surface: surface,
      onSurface: onSurface,
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainerHighest: surfaceContainerHighest,
      outline: outlineVariant,
      outlineVariant: outlineVariant,
      surfaceTint: surfaceTint,
      secondary: primary, // Using primary as secondary per design
      onSecondary: Colors.white,
    );
  }
}

/// Predefined shadow styles aligned with the "No-Drop-Shadow" rule
/// Use "Cloud Shadow" for floating elements only
class AppShadows {
  AppShadows._();

  /// Cloud Shadow - For floating Action Buttons or triggered Menus
  /// Blur: 32px | Y-Offset: 8px | Color: onSurface at 6%
  static List<BoxShadow> get cloudShadow {
    return [
      BoxShadow(
        color: AppColors.onSurface.withOpacity(0.06),
        blurRadius: 32,
        offset: const Offset(0, 8),
      ),
    ];
  }

  /// No shadow - For static cards (use tonal layering instead)
  static List<BoxShadow> get none {
    return [];
  }
}

/// Gradient presets for CTAs and hero elements
class AppGradients {
  AppGradients._();

  /// Primary CTA gradient (135 degree angle)
  /// From primary (#005bc4) to primaryContainer (#4388fd)
  static LinearGradient get ctaPrimary {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.primary, AppColors.primaryContainer],
    );
  }

  /// Alternative subtle gradient for secondary CTAs
  static LinearGradient get ctaSecondary {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.primaryContainer, AppColors.primary],
    );
  }
}

/// Corner radius presets per design system
class AppRadii {
  AppRadii._();

  /// Extra large radius - For buttons and cards (1.5rem = 24dp)
  static const double xl = 24.0;

  /// Large radius - For cards and containers (1rem = 16dp)
  static const double lg = 16.0;

  /// Small radius - For input fields (0.25rem = 4dp)
  static const double sm = 4.0;

  /// Full rounding - For chips (9999px)
  static const double full = 9999.0;
}

/// Spacing/Padding presets
class AppSpacing {
  AppSpacing._();

  /// Safety margin from screen edge (24dp)
  static const double safetyMargin = 24.0;

  /// Standard vertical spacing for list items
  static const double verticalSpacing = 16.0;

  /// Standard horizontal padding
  static const double horizontalPadding = 16.0;
}
