import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_info_tile.dart';

class InspectionPreviewCard extends StatelessWidget {
  const InspectionPreviewCard({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppInfoTile(
      icon: Icons.description_outlined,
      title: title,
      subtitle: value,
    );
  }
}
