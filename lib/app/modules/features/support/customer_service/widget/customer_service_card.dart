import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_info_tile.dart';

class CustomerServiceCard extends StatelessWidget {
  const CustomerServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppInfoTile(
      icon: Icons.support_agent_outlined,
      title: 'Customer Service',
      subtitle: 'Hubungi tim support operasional.',
    );
  }
}
