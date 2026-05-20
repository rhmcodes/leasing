import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_info_tile.dart';

class VehicleConditionCard extends StatelessWidget {
  const VehicleConditionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppInfoTile(
      icon: Icons.fact_check_outlined,
      title: 'Vehicle Condition',
      subtitle: 'Ringkasan kondisi kendaraan.',
    );
  }
}
