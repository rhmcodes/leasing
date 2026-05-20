import 'package:flutter/material.dart';

import '../../../../shared/widgets/app_scaffold.dart';
import '../widget/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      title: 'Login',
      scrollable: true,
      showTitle: false,
      body: LoginForm(),
    );
  }
}
