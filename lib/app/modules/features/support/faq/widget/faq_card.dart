import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_info_tile.dart';

class FaqCard extends StatelessWidget {
  const FaqCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppInfoTile(
      icon: Icons.help_outline,
      title: 'FAQ',
      subtitle: 'Pertanyaan umum seputar proses inspeksi.',
    );
  }
}
