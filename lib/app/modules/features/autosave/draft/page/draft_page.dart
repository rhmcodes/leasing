import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_scaffold.dart';
import '../widget/draft_card.dart';

class DraftPage extends StatelessWidget {
  const DraftPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Draft',
      showBackButton: true,
      body: DraftCard(title: 'Draft inspeksi tersimpan'),
    );
  }
}
