import 'package:flutter/material.dart';

import '../../../../../core/theme/app_spacing.dart';

class InspectionPreviewSection extends StatelessWidget {
  const InspectionPreviewSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        context.gapV8,
        ...children,
      ],
    );
  }
}
