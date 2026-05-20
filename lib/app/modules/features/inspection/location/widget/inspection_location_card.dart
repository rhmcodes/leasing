import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_info_tile.dart';

class InspectionLocationCard extends StatelessWidget {
  const InspectionLocationCard({
    super.key,
    required this.latitude,
    required this.longitude,
    this.accuracy,
  });

  final double latitude;
  final double longitude;
  final double? accuracy;

  @override
  Widget build(BuildContext context) {
    return AppInfoTile(
      icon: Icons.location_on_outlined,
      title: '$latitude, $longitude',
      subtitle: 'Accuracy: ${accuracy?.toStringAsFixed(1) ?? '-'} m',
    );
  }
}
