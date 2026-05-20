import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_scaffold.dart';
import '../widget/profile_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Profil',
      scrollable: true,
      showTitle: false,
      body: ProfileCard(),
    );
  }
}
