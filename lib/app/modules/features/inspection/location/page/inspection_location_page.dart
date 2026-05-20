import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_empty_state.dart';
import '../../../../../shared/widgets/app_scaffold.dart';

class InspectionLocationPage extends StatelessWidget {
  const InspectionLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Lokasi Inspeksi',
      showBackButton: true,
      body: AppEmptyState(message: 'Lokasi inspeksi belum dipilih.'),
    );
  }
}
