import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_info_tile.dart';

class VehicleHistoryCard extends StatelessWidget {
  const VehicleHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppInfoTile(
      icon: Icons.history_outlined,
      title: 'Riwayat kendaraan',
      subtitle: 'Belum ada inspeksi kendaraan tersimpan.',
    );
  }
}
