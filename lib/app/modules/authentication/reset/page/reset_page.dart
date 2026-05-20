import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_scaffold.dart';
import '../widget/reset_form.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Reset',
      scrollable: true,
      showTitle: false,
      showBackButton: true,
      body: ResetForm(),
    );
  }
}
