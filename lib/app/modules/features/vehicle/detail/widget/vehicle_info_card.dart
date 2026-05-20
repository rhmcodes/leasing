import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_info_tile.dart';

class VehicleInfoCard extends StatelessWidget {
  const VehicleInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppInfoTile(
      icon: Icons.two_wheeler_outlined,
      title: 'Vehicle Info',
      subtitle: 'Informasi kendaraan inspeksi.',
    );
  }
}
