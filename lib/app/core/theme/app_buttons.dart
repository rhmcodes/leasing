import 'package:flutter/material.dart';

import '../utils/app_responsive.dart';
import 'app_colors.dart';
import 'app_fonts.dart';
import 'app_radius.dart';
import 'app_shadow.dart';
import 'app_spacing.dart';

/// Reusable button styles and icon buttons.
class AppButtons {
  const AppButtons._();

  static const double _defaultHeight = 56;
  static const double _minTouchTarget = 44;

  static BorderRadius _radius(
    BuildContext context, [
    double radius = AppRadius.lg,
  ]) {
    return AppRadius.circular(context, radius);
  }

  static Size _size(BuildContext context, double height, [double? width]) {
    return Size(width ?? double.infinity, context.res(height));
  }

  static EdgeInsets _padding(BuildContext context) {
    return AppSpacing.symmetric(context, horizontal: 20, vertical: 12);
  }

  static ButtonStyle _filledStyle(
    BuildContext context, {
    required Color backgroundColor,
    required Color foregroundColor,
    double? width,
    double height = _defaultHeight,
    double elevation = 0,
    Color? shadowColor,
    Color? disabledBackgroundColor,
    Color? disabledForegroundColor,
    TextStyle? textStyle,
  }) {
    return ElevatedButton.styleFrom(
      minimumSize: _size(context, height, width),
      padding: _padding(context),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      disabledBackgroundColor: disabledBackgroundColor,
      disabledForegroundColor: disabledForegroundColor,
      elevation: elevation,
      shadowColor: shadowColor,
      textStyle: textStyle ?? AppFonts.headline(foregroundColor),
      shape: RoundedRectangleBorder(borderRadius: _radius(context)),
      tapTargetSize: MaterialTapTargetSize.padded,
    );
  }

  // ---------------------------------------------------------------------------
  // Button styles
  // ---------------------------------------------------------------------------
  static ButtonStyle primary(BuildContext context, {double? width}) {
    return _filledStyle(
      context,
      width: width,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.onPrimary,
    );
  }

  static ButtonStyle secondary(BuildContext context, {double? width}) {
    return _filledStyle(
      context,
      width: width,
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.onSecondary,
    );
  }

  /// Accent CTA for high-emphasis actions.
  static ButtonStyle accentCta(BuildContext context, {required bool busy}) {
    return _filledStyle(
      context,
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.onAccent,
      disabledBackgroundColor: AppColors.accent.withAlpha(128),
      disabledForegroundColor: AppColors.primary.withAlpha(153),
      elevation: busy ? 0 : 10,
      shadowColor: AppColors.accent.withAlpha(115),
      textStyle: AppFonts.headline(
        AppColors.onAccent,
      ).copyWith(
        fontSize: 16,
        fontWeight: AppFonts.semibold,
      ),
    );
  }

  static ButtonStyle glass(BuildContext context, {double? width}) {
    return _filledStyle(
      context,
      width: width,
      backgroundColor: AppColors.white.withAlpha(38),
      foregroundColor: AppColors.white,
    ).copyWith(
      side: WidgetStatePropertyAll<BorderSide>(
        BorderSide(color: AppColors.white.withAlpha(0)),
      ),
    );
  }

  static ButtonStyle outline(
    BuildContext context, {
    double? width,
    bool onDark = false,
  }) {
    final Color borderColor = onDark
        ? AppColors.white.withAlpha(0)
        : AppColors.transparent;
    final Color foregroundColor = onDark ? AppColors.white : AppColors.primary;

    return OutlinedButton.styleFrom(
      minimumSize: _size(context, _defaultHeight, width),
      padding: _padding(context),
      foregroundColor: foregroundColor,
      textStyle: AppFonts.headline(foregroundColor),
      side: BorderSide(color: borderColor, width: 1.2),
      shape: RoundedRectangleBorder(borderRadius: _radius(context)),
      tapTargetSize: MaterialTapTargetSize.padded,
    );
  }

  // ---------------------------------------------------------------------------
  // Icon buttons
  // ---------------------------------------------------------------------------
  static Widget circleBack({
    VoidCallback? onTap,
    double? size,
    Color? iconColor,
    Color? bgColor,
    String? tooltip,
  }) {
    return Builder(
      builder: (BuildContext context) {
        return circleIcon(
          icon: Icons.chevron_left_rounded,
          onTap: onTap ?? () => Navigator.of(context).maybePop(),
          size: size,
          iconColor: iconColor,
          bgColor: bgColor,
          tooltip: tooltip ?? 'Back',
        );
      },
    );
  }

  static Widget circleIcon({
    required IconData icon,
    VoidCallback? onTap,
    double? size,
    Color? iconColor,
    Color? bgColor,
    List<BoxShadow>? shadows,
    String? tooltip,
  }) {
    return Builder(
      builder: (BuildContext context) {
        final double visualSize = size ?? context.res(40);
        final double tapSize = visualSize < _minTouchTarget
            ? context.res(_minTouchTarget)
            : visualSize;

        final Widget button = SizedBox.square(
          dimension: tapSize,
          child: Center(
            child: Material(
              color: AppColors.transparent,
              child: InkWell(
                onTap: onTap,
                customBorder: const CircleBorder(),
                child: Ink(
                  width: visualSize,
                  height: visualSize,
                  decoration: BoxDecoration(
                    color: bgColor ?? AppColors.card,
                    shape: BoxShape.circle,
                    boxShadow: shadows ?? AppShadows.card,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor ?? AppColors.textPrimary,
                    size: visualSize * 0.5,
                  ),
                ),
              ),
            ),
          ),
        );

        if (tooltip == null || tooltip.isEmpty) return button;

        return Tooltip(
          message: tooltip,
          child: Semantics(
            button: true,
            enabled: onTap != null,
            label: tooltip,
            child: button,
          ),
        );
      },
    );
  }
}
