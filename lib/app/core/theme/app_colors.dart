import 'package:flutter/material.dart';

/// Centralized brand and semantic color tokens.
class AppColors {
  const AppColors._();

  // ---------------------------------------------------------------------------
  // Brand - NSS Dealer / PT. Nusantara Sakti Group
  // ---------------------------------------------------------------------------
  static const Color primary = Color(0xFFD90429);
  static const Color primaryDark = Color(0xFFA8001F);
  static const Color primaryLight = Color(0xFFFFE8EC);

  static const Color secondary = Color(0xFF1F2937);
  static const Color secondaryDark = Color(0xFF111827);
  static const Color secondaryLight = Color(0xFFF3F4F6);

  static const Color accent = Color(0xFFFFB703);
  static const Color accentSoft = Color(0xFFFFF4CC);

  static const Color onPrimary = Colors.white;
  static const Color onSecondary = Colors.white;
  static const Color onAccent = Color(0xFF3A2500);

  // ---------------------------------------------------------------------------
  // Base
  // ---------------------------------------------------------------------------
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;

  // ---------------------------------------------------------------------------
  // Surfaces
  // ---------------------------------------------------------------------------
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Colors.white;
  static const Color surfaceMuted = Color(0xFFF1F5F9);
  static const Color card = Colors.white;
  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color overlay = Color(0x14D90429);

  // Backward-compatible surface aliases.
  static const Color bgDark = primaryDark;
  static const Color bgLight = background;

  // ---------------------------------------------------------------------------
  // Deep visual surfaces, not a dark theme mode.
  // ---------------------------------------------------------------------------
  static const Color darkSurface = Color(0xFF1A0710);
  static const Color darkSurfaceMuted = Color(0xFF2A0A16);
  static const Color darkOutline = Color(0xFF5A1824);
  static const Color darkTextSecondary = Color(0xFFE2E8F0);
  static const Color darkTextMuted = Color(0xFFCBD5E1);

  // ---------------------------------------------------------------------------
  // Text
  // ---------------------------------------------------------------------------
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textDisabled = Color(0xFF94A3B8);
  static const Color textOnDark = Colors.white;

  // ---------------------------------------------------------------------------
  // States
  // ---------------------------------------------------------------------------
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF0284C7);

  static const Color successSoft = Color(0xFFEAF7EE);
  static const Color warningSoft = Color(0xFFFFF7E6);
  static const Color errorSoft = Color(0xFFFDECEC);
  static const Color infoSoft = Color(0xFFE8F5FC);

  // ---------------------------------------------------------------------------
  // Supporting accents
  // ---------------------------------------------------------------------------
  static const Color emerald = Color(0xFF34D399);
  static const Color lime = Color(0xFF4ADE80);
  static const Color sky = Color(0xFF38BDF8);
  static const Color blue = Color(0xFF2563EB);
  static const Color amber = Color(0xFFFFB703);
  static const Color gold = Color(0xFFF6C453);
  static const Color warmGold = Color(0xFFF4C15D);
  static const Color orange = Color(0xFFFB8500);
  static const Color violet = Color(0xFFA78BFA);
  static const Color rose = Color(0xFFFB7185);
  static const Color red = Color(0xFFD90429);
  static const Color alert = Color(0xFFEF4444);
  static const Color coral = Color(0xFFFF5D5D);
  static const Color green = Color(0xFF22C55E);

  // ---------------------------------------------------------------------------
  // Location
  // ---------------------------------------------------------------------------
  static const Color locationIn = Color(0xFF2563EB);
  static const Color locationOut = Color(0xFFDC2626);

  // ---------------------------------------------------------------------------
  // Premium visual surfaces
  // ---------------------------------------------------------------------------
  static const Color glassBase = Color(0xFF1A0710);
  static const Color glassTop = Color(0xFFB00020);
  static const Color glassMid = Color(0xFFD90429);
  static const Color glassBottom = Color(0xFF7F0018);
  static const Color snackbarBase = Color(0xFF111827);
  static const Color snackbarTop = Color(0xFF1F2937);
  static const Color snackbarMid = Color(0xFF111827);
  static const Color heroOverlayTop = Color(0xD91A0710);
  static const Color heroOverlayMid = Color(0xB3A8001F);
  static const Color heroOverlayBottom = Color(0xE6070205);
  static const Color biometricAccent = Color(0xFFFFB703);
  static const Color biometricMapTop = Color(0xFF7F0018);
  static const Color biometricMapBottom = Color(0xFF1A0710);
  static const Color biometricRoad = Color(0xFFE11D48);
  static const Color selectedSurface = Color(0xFFFFE8EC);
  static const Color avatarSurface = Color(0xFFFFF4CC);
  static const Color bottomBarSurface = Color(0xFF111827);

  // ---------------------------------------------------------------------------
  // Header
  // ---------------------------------------------------------------------------
  static const Color headerTop = Color(0xFFFF4D5E);
  static const Color headerUpper = Color(0xFFE11D48);
  static const Color headerMiddle = Color(0xFFD90429);
  static const Color headerLower = Color(0xFFB00020);
  static const Color headerBottom = Color(0xFF7F0018);
  static const Color headerForeground = Colors.white;

  static const List<Color> headerGradient = <Color>[
    headerTop,
    headerUpper,
    headerMiddle,
    headerLower,
    headerBottom,
  ];

  static const List<double> headerGradientStops = <double>[
    0.0,
    0.25,
    0.5,
    0.75,
    1.0,
  ];

  // ---------------------------------------------------------------------------
  // Gradients
  // ---------------------------------------------------------------------------
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[headerUpper, primary, primaryDark],
    stops: <double>[0.0, 0.52, 1.0],
  );

  static const LinearGradient screenGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color(0xFFFFFFFF),
      Color(0xFFFFF7F8),
      background,
    ],
    stops: <double>[0.0, 0.42, 1.0],
  );

  static const LinearGradient softBlueGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0xFFFFFFFF), primaryLight, background],
    stops: <double>[0.0, 0.55, 1.0],
  );

  static const LinearGradient darkFlow = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[glassTop, glassMid, glassBottom],
    stops: <double>[0.0, 0.46, 1.0],
  );

  static const RadialGradient cyanGlow = RadialGradient(
    colors: <Color>[Color(0x26FFB703), Color(0x00FFB703)],
  );

  static const RadialGradient tealGlow = RadialGradient(
    colors: <Color>[Color(0x1FD90429), Color(0x00D90429)],
  );

  static const LinearGradient softWash = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Color(0x1AFFB703), Color(0x0DD90429), Color(0x00F8FAFC)],
    stops: <double>[0.0, 0.36, 1.0],
  );

  static const RadialGradient calmGlow = RadialGradient(
    colors: <Color>[Color(0x1AD90429), Color(0x00D90429)],
  );

  static const RadialGradient sideGlow = RadialGradient(
    colors: <Color>[Color(0x14FFB703), Color(0x00FFB703)],
  );
}
