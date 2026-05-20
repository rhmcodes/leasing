import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../router/app_routes.dart';
import '../../../../shared/widgets/app_brand_header.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.screenGradient),
        child: SafeArea(
          minimum: AppSpacing.screen(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const AppBrandHeader(
                title: AppConstants.appName,
                subtitle: AppConstants.companyName,
                icon: Icons.fact_check_outlined,
              ),
              context.gapV24,
              Text(
                'Inspeksi kendaraan lapangan',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              context.gapV12,
              Text(
                'Dokumentasi foto, GPS, tanda tangan, dan autosave offline untuk proses survey yang rapi.',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.textSecondary),
              ),
              context.gapV32,
              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.login,
                ),
                child: const Text('Mulai'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
