import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadow.dart';
import '../../core/theme/app_spacing.dart';

class AppBrandHeader extends StatelessWidget {
  const AppBrandHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.two_wheeler_rounded,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.card(context),
      decoration: BoxDecoration(
        gradient: AppColors.brandGradient,
        borderRadius: AppRadius.radiusLg(context),
        boxShadow: AppShadows.cardMedium,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.white.withAlpha(32),
              borderRadius: AppRadius.radiusMd(context),
            ),
            child: Icon(icon, color: AppColors.white, size: 28),
          ),
          context.gapH12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppColors.white),
                ),
                context.gapV4,
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.white.withAlpha(220)),
                ),
              ],
            ),
          ),
          if (trailing != null) ...<Widget>[
            context.gapH12,
            trailing!,
          ],
        ],
      ),
    );
  }
}
