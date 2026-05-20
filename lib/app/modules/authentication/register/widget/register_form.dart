import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../router/app_routes.dart';
import '../../../../shared/widgets/app_brand_header.dart';
import '../../../../shared/widgets/app_text_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _submit() {
    final bool valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    Navigator.of(context).maybePop();
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
            icon: Icons.badge_outlined,
          ),
          context.gapV24,
          Text(
            'Registrasi Surveyor',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          context.gapV8,
          Text(
            'Form registrasi akan digunakan untuk membuat akses inspeksi lapangan.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          context.gapV24,
          AppTextField(
            controller: _nameController,
            label: 'Nama Surveyor',
            prefixIcon: Icons.badge_outlined,
            textInputAction: TextInputAction.next,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return 'Nama wajib diisi';
              }
              return null;
            },
          ),
          context.gapV16,
          AppTextField(
            controller: _usernameController,
            label: 'Username',
            prefixIcon: Icons.person_outline,
            textInputAction: TextInputAction.done,
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return 'Username wajib diisi';
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
            label: const Text('Sudah punya akun'),
          ),
        ],
      ),
    );
  }
}
