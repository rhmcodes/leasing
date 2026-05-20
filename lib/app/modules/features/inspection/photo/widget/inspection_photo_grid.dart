import 'package:flutter/material.dart';

import '../../../../../core/theme/app_spacing.dart';

class InspectionPhotoGrid extends StatelessWidget {
  const InspectionPhotoGrid({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.s12(context),
      mainAxisSpacing: AppSpacing.s12(context),
      children: children,
    );
  }
}
