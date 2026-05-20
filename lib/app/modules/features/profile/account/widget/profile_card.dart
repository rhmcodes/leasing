import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadow.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../router/app_routes.dart';
import '../../../../../shared/widgets/app_surface.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature sedang disiapkan.')),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: AppColors.transparent,
          insetPadding: AppSpacing.h24(dialogContext),
          child: AppSurface(
            shadows: AppShadows.modal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.errorSoft,
                        borderRadius: AppRadius.radiusMd(dialogContext),
                      ),
                      child: const Icon(
                        Icons.logout_rounded,
                        color: AppColors.error,
                      ),
                    ),
                    dialogContext.gapH12,
                    Expanded(
                      child: Text(
                        'Keluar akun?',
                        style: Theme.of(dialogContext).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                dialogContext.gapV12,
                Text(
                  'Pastikan draft inspeksi sudah tersimpan sebelum keluar.',
                  style: Theme.of(dialogContext).textTheme.bodyMedium,
                ),
                dialogContext.gapV20,
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(dialogContext, false),
                        child: const Text('Batal'),
                      ),
                    ),
                    dialogContext.gapH12,
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(dialogContext, true),
                        child: const Text('Keluar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (confirmed != true || !context.mounted) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        AppSurface(
          gradient: AppColors.brandGradient,
          shadows: AppShadows.cardMedium,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.white.withAlpha(38),
                      borderRadius: AppRadius.radiusLg(context),
                    ),
                    child: const Icon(
                      Icons.person_outline_rounded,
                      color: AppColors.white,
                      size: 34,
                    ),
                  ),
                  context.gapH14,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Surveyor NSS',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: AppColors.white),
                        ),
                        context.gapV4,
                        Text(
                          'PT. Nusantara Sakti Group',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.white.withAlpha(220)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              context.gapV18,
              Wrap(
                spacing: AppSpacing.s8(context),
                runSpacing: AppSpacing.s8(context),
                children: <Widget>[
                  const _StatusPill(
                    icon: Icons.verified_outlined,
                    label: 'Akun aktif',
                    onDark: true,
                  ),
                  const _StatusPill(
                    icon: Icons.badge_outlined,
                    label: 'NSS-FI-001',
                    onDark: true,
                  ),
                ],
              ),
            ],
          ),
        ),
        context.gapV16,
        Row(
          children: <Widget>[
            const Expanded(
              child: _ProfileMetric(
                title: 'Inspeksi',
                value: '24',
                icon: Icons.fact_check_outlined,
                color: AppColors.info,
                background: AppColors.infoSoft,
              ),
            ),
            context.gapH12,
            const Expanded(
              child: _ProfileMetric(
                title: 'Pending',
                value: '3',
                icon: Icons.sync_outlined,
                color: AppColors.warning,
                background: AppColors.warningSoft,
              ),
            ),
          ],
        ),
        context.gapV16,
        AppSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Informasi Akun',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              context.gapV12,
              const _ProfileInfoRow(
                icon: Icons.phone_android_outlined,
                label: 'Nomor perangkat',
                value: 'Device terverifikasi',
              ),
              context.gapV12,
              const _ProfileInfoRow(
                icon: Icons.location_on_outlined,
                label: 'Area kerja',
                value: 'Semarang Raya',
              ),
              context.gapV12,
              const _ProfileInfoRow(
                icon: Icons.access_time_outlined,
                label: 'Shift aktif',
                value: '08:00 - 17:00 WIB',
              ),
              context.gapV12,
              const _ProfileInfoRow(
                icon: Icons.cloud_done_outlined,
                label: 'Status sinkronisasi',
                value: 'Online-ready',
              ),
            ],
          ),
        ),
        context.gapV16,
        AppSurface(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Preferensi', style: Theme.of(context).textTheme.titleLarge),
              context.gapV12,
              _ProfileActionTile(
                icon: Icons.lock_outline_rounded,
                title: 'Keamanan Akun',
                subtitle: 'PIN, password, dan akses perangkat',
                onTap: () => _showComingSoon(context, 'Keamanan akun'),
              ),
              context.gapV10,
              _ProfileActionTile(
                icon: Icons.notifications_none_rounded,
                title: 'Notifikasi',
                subtitle: 'Pengingat inspeksi dan status sync',
                onTap: () => _showComingSoon(context, 'Notifikasi'),
              ),
              context.gapV10,
              _ProfileActionTile(
                icon: Icons.help_outline_rounded,
                title: 'Bantuan Lapangan',
                subtitle: 'FAQ, customer service, dan panduan inspeksi',
                onTap: () => _showComingSoon(context, 'Bantuan lapangan'),
              ),
            ],
          ),
        ),
        context.gapV16,
        _LogoutAction(onTap: () => _confirmLogout(context)),
      ],
    );
  }
}

class _ProfileMetric extends StatelessWidget {
  const _ProfileMetric({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.background,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: background,
              borderRadius: AppRadius.radiusMd(context),
            ),
            child: Icon(icon, color: color),
          ),
          context.gapV12,
          Text(value, style: Theme.of(context).textTheme.displayMedium),
          context.gapV4,
          Text(title, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.surfaceMuted,
            borderRadius: AppRadius.radiusMd(context),
          ),
          child: Icon(icon, color: AppColors.textSecondary),
        ),
        context.gapH12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label, style: Theme.of(context).textTheme.bodySmall),
              context.gapV4,
              Text(value, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileActionTile extends StatelessWidget {
  const _ProfileActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceMuted,
        borderRadius: AppRadius.radiusLg(context),
        boxShadow: AppShadows.card,
      ),
      child: Material(
        color: AppColors.transparent,
        borderRadius: AppRadius.radiusLg(context),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: AppSpacing.card(context),
            child: Row(
              children: <Widget>[
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppRadius.radiusMd(context),
                  ),
                  child: Icon(icon, color: AppColors.primary),
                ),
                context.gapH12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      context.gapV4,
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoutAction extends StatelessWidget {
  const _LogoutAction({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.errorSoft,
        borderRadius: AppRadius.radiusLg(context),
        boxShadow: AppShadows.card,
      ),
      child: Material(
        color: AppColors.transparent,
        borderRadius: AppRadius.radiusLg(context),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: AppSpacing.card(context),
            child: Row(
              children: <Widget>[
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: AppRadius.radiusMd(context),
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: AppColors.error,
                  ),
                ),
                context.gapH12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Logout',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: AppColors.error),
                      ),
                      context.gapV4,
                      Text(
                        'Keluar dari akun surveyor di perangkat ini',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: AppColors.error),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.error,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({
    required this.icon,
    required this.label,
    this.onDark = false,
  });

  final IconData icon;
  final String label;
  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final Color foreground =
        onDark ? AppColors.white : AppColors.textSecondary;
    final Color background =
        onDark ? AppColors.white.withAlpha(34) : AppColors.surfaceMuted;

    return Container(
      padding: AppSpacing.symmetric(context, horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadius.radiusFull(context),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 16, color: foreground),
          context.gapH6,
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: foreground),
          ),
        ],
      ),
    );
  }
}
