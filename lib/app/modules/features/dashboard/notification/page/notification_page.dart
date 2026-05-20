import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_empty_state.dart';
import '../../../../../shared/widgets/app_scaffold.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Notification',
      showBackButton: true,
      body: AppEmptyState(message: 'Belum ada notifikasi.'),
    );
  }
}
