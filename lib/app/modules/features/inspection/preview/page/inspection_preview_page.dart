import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_empty_state.dart';
import '../../../../../shared/widgets/app_scaffold.dart';

class InspectionPreviewPage extends StatelessWidget {
  const InspectionPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Preview Inspeksi',
      showBackButton: true,
      body: AppEmptyState(message: 'Data inspeksi belum tersedia.'),
    );
  }
}
