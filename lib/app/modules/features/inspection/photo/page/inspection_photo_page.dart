import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_empty_state.dart';
import '../../../../../shared/widgets/app_scaffold.dart';

class InspectionPhotoPage extends StatelessWidget {
  const InspectionPhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Foto Inspeksi',
      showBackButton: true,
      body: AppEmptyState(message: 'Foto inspeksi belum tersedia.'),
    );
  }
}
