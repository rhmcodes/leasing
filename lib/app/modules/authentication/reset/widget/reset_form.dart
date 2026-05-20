import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../router/app_routes.dart';
import '../../../../shared/widgets/app_brand_header.dart';
import '../../../../shared/widgets/app_text_field.dart';

class ResetForm extends StatefulWidget {
  const ResetForm({super.key});

  @override
  State<ResetForm> createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    final bool valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.login,
      (Route<dynamic> route) => false,
    );
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
            icon: Icons.security_outlined,
          ),
          context.gapV24,
          Text(
            'Reset Akses',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          context.gapV8,
          Text(
            'Buat akses baru untuk melanjutkan proses inspeksi.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          context.gapV24,
          AppTextField(
            controller: _passwordController,
            label: 'Password Baru',
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            textInputAction: TextInputAction.next,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return 'Password wajib diisi';
              }
              return null;
            },
          ),
          context.gapV16,
          AppTextField(
            controller: _confirmPasswordController,
            label: 'Konfirmasi Password',
            prefixIcon: Icons.lock_person_outlined,
            obscureText: true,
            textInputAction: TextInputAction.done,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return 'Konfirmasi password wajib diisi';
              }
              if (value != _passwordController.text) {
                return 'Konfirmasi password tidak sama';
              }
              return null;
            },
          ),
          context.gapV16,
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Simpan'),
          ),
          context.gapV12,
          TextButton.icon(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (Route<dynamic> route) => false,
            ),
            icon: const Icon(Icons.login_outlined),
            label: const Text('Kembali ke Login'),
          ),
        ],
      ),
    );
  }
}
