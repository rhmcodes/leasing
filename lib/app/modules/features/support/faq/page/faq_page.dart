import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_scaffold.dart';
import '../widget/faq_card.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'FAQ',
      showBackButton: true,
      body: FaqCard(),
    );
  }
}
