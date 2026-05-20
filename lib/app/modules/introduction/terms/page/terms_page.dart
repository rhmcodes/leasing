import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_scaffold.dart';
import '../widget/terms_content.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Terms & Conditions',
      showBackButton: true,
      body: TermsContent(),
    );
  }
}
