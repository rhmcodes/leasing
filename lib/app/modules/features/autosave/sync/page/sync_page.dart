import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_scaffold.dart';
import '../widget/sync_card.dart';

class SyncPage extends StatelessWidget {
  const SyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Sync',
      showBackButton: true,
      body: SyncCard(title: 'Pending Sync'),
    );
  }
}
