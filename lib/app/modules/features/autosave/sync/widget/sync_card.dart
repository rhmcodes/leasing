import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_info_tile.dart';

class SyncCard extends StatelessWidget {
  const SyncCard({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppInfoTile(
      icon: Icons.sync_outlined,
      title: title,
      subtitle: 'Antrean akan dikirim saat koneksi tersedia.',
    );
  }
}
