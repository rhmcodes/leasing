import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../router/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/app_brand_header.dart';
import '../../../../shared/widgets/app_text_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController(
    text: 'surveyor.nss',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: 'password',
  );

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final bool valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    Navigator.pushReplacementNamed(context, AppRoutes.main);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const AppBrandHeader(
            title: AppConstants.appName,
            subtitle: AppConstants.companyName,
            icon: Icons.verified_user_outlined,
          ),
          context.gapV24,
          Text(
            'Masuk sebagai Surveyor',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          context.gapV8,
          Text(
            'Gunakan akun lapangan untuk mengakses dashboard inspeksi.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          context.gapV24,
          AppTextField(
            controller: _usernameController,
            label: 'Username',
            prefixIcon: Icons.person_outline,
            textInputAction: TextInputAction.next,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return 'Username wajib diisi';
              }
              return null;
            },
          ),
          context.gapV16,
          AppTextField(
            controller: _passwordController,
            label: 'Password',
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            textInputAction: TextInputAction.done,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return 'Password wajib diisi';
              }
              return null;
            },
          ),
          context.gapV24,
          ElevatedButton(
            onPressed: _login,
            child: const Text('Masuk'),
          ),
          context.gapV12,
          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppSpacing.s8(context),
            runSpacing: AppSpacing.s4(context),
            children: <Widget>[
              TextButton.icon(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.forgot),
                icon: const Icon(Icons.lock_reset_outlined),
                label: const Text('Lupa akses'),
              ),
              TextButton.icon(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
                icon: const Icon(Icons.person_add_alt_1_outlined),
                label: const Text('Daftar surveyor'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
