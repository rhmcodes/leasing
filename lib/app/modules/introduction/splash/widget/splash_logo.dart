import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({
    super.key,
    this.size = 82,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: AppRadius.radiusLg(context),
      ),
      child: Center(
        child: Icon(
          Icons.two_wheeler_rounded,
          color: AppColors.primary,
          size: size * 0.58,
        ),
      ),
    );
  }
}
