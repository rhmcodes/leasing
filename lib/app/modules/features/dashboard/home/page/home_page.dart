import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/widgets/app_brand_header.dart';
import '../../../../../shared/widgets/app_info_tile.dart';
import '../../../../../shared/widgets/app_scaffold.dart';
import '../widget/summary_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Dashboard',
      scrollable: true,
      showTitle: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppBrandHeader(
            title: 'NSS Field Inspection',
            subtitle: 'PT. Nusantara Sakti Group',
            icon: Icons.fact_check_outlined,
            trailing: IconButton(
              onPressed: () {},
              color: AppColors.white,
              icon: const Icon(Icons.notifications_none_outlined),
              tooltip: 'Notifikasi',
            ),
          ),
          context.gapV24,
          Row(
            children: <Widget>[
              const Expanded(
                child: SummaryCard(
                  title: 'Draft',
                  value: '0',
                  icon: Icons.edit_note_outlined,
                ),
              ),
              context.gapH12,
              const Expanded(
                child: SummaryCard(
                  title: 'Pending Sync',
                  value: '0',
                  icon: Icons.sync_outlined,
                ),
              ),
            ],
          ),
          context.gapV24,
          Column(
            children: <Widget>[
              const AppInfoTile(
                icon: Icons.location_on_outlined,
                title: 'Validasi lapangan',
                subtitle:
                    'GPS, foto, dan watermark dipakai untuk menjaga akurasi data.',
              ),
              context.gapV12,
              const AppInfoTile(
                icon: Icons.cloud_queue_outlined,
                title: 'Offline-ready',
                subtitle:
                    'Draft dan antrean sync disiapkan saat koneksi terbatas.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
