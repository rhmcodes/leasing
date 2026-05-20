import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_info_tile.dart';

class TermsContent extends StatelessWidget {
  const TermsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppInfoTile(
      icon: Icons.policy_outlined,
      title: 'Terms & Conditions',
      subtitle: 'Gunakan aplikasi sesuai prosedur inspeksi lapangan.',
    );
  }
}
