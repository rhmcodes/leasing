import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadow.dart';
import '../../core/theme/app_spacing.dart';

class AppSurface extends StatelessWidget {
  const AppSurface({
    super.key,
    required this.child,
    this.padding,
    this.gradient,
    this.color = AppColors.surface,
    this.shadows = AppShadows.card,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Gradient? gradient;
  final Color color;
  final List<BoxShadow> shadows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? AppSpacing.card(context),
      decoration: BoxDecoration(
        color: gradient == null ? color : null,
        gradient: gradient,
        borderRadius: AppRadius.radiusLg(context),
        boxShadow: shadows,
      ),
      child: child,
    );
  }
}
