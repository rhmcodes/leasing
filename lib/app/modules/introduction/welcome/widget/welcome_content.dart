import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_info_tile.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppInfoTile(
      icon: Icons.offline_bolt_outlined,
      title: 'Offline-ready',
      subtitle: 'Dokumentasikan kendaraan dengan cepat, akurat, dan offline-ready.',
    );
  }
}
