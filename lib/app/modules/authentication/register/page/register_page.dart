import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_scaffold.dart';
import '../widget/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Register',
      scrollable: true,
      showTitle: false,
      showBackButton: true,
      body: RegisterForm(),
    );
  }
}
