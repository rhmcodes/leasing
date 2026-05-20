import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_info_tile.dart';

class DraftCard extends StatelessWidget {
  const DraftCard({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppInfoTile(
      icon: Icons.edit_note_outlined,
      title: title,
      subtitle: 'Data dapat dilanjutkan saat surveyor kembali.',
    );
  }
}
