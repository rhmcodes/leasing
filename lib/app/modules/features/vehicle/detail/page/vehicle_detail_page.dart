import 'package:flutter/material.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/widgets/app_scaffold.dart';
import '../widget/vehicle_condition_card.dart';
import '../widget/vehicle_info_card.dart';

class VehicleDetailPage extends StatelessWidget {
  const VehicleDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Detail Kendaraan',
      showBackButton: true,
      body: _VehicleDetailContent(),
    );
  }
}

class _VehicleDetailContent extends StatelessWidget {
  const _VehicleDetailContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const VehicleInfoCard(),
        context.gapV16,
        const VehicleConditionCard(),
      ],
    );
  }
}
