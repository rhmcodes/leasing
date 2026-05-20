import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../router/app_routes.dart';
import '../../../../shared/widgets/app_brand_header.dart';
import '../../../../shared/widgets/app_text_field.dart';

class ForgotForm extends StatefulWidget {
  const ForgotForm({super.key});

  @override
  State<ForgotForm> createState() => _ForgotFormState();
}

class _ForgotFormState extends State<ForgotForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _submit() {
    final bool valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    Navigator.pushNamed(context, AppRoutes.reset);
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
            icon: Icons.lock_reset_outlined,
          ),
          context.gapV24,
          Text(
            'Pemulihan Akun',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          context.gapV8,
          Text(
            'Masukkan data akun untuk memulai proses pemulihan.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          context.gapV24,
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
            child: const Text('Lanjut Reset Akses'),
          ),
          context.gapV12,
          TextButton.icon(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (Route<dynamic> route) => false,
            ),
            icon: const Icon(Icons.arrow_back_rounded),
            label: const Text('Kembali ke Login'),
          ),
        ],
      ),
    );
  }
}
