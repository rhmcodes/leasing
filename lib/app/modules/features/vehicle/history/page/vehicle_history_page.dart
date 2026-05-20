import 'package:flutter/material.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/widgets/app_brand_header.dart';
import '../../../../../shared/widgets/app_scaffold.dart';
import '../widget/vehicle_history_card.dart';

class VehicleHistoryPage extends StatelessWidget {
  const VehicleHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Riwayat Kendaraan',
      showTitle: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const AppBrandHeader(
            title: 'Riwayat Kendaraan',
            subtitle:
                'Pantau draft, inspeksi tersimpan, dan status sinkronisasi.',
            icon: Icons.history_rounded,
          ),
          context.gapV16,
          const VehicleHistoryCard(),
        ],
      ),
    );
  }
}
