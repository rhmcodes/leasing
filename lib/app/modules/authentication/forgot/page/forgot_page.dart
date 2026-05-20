import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_scaffold.dart';
import '../widget/forgot_form.dart';

class ForgotPage extends StatelessWidget {
  const ForgotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Forgot',
      scrollable: true,
      showTitle: false,
      showBackButton: true,
      body: ForgotForm(),
    );
  }
}
