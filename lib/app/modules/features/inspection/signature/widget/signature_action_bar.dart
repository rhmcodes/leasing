import 'package:flutter/material.dart';

import '../../../../../core/theme/app_spacing.dart';

class SignatureActionBar extends StatelessWidget {
  const SignatureActionBar({
    super.key,
    required this.onClear,
    required this.onSave,
  });

  final VoidCallback onClear;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: OutlinedButton(
            onPressed: onClear,
            child: const Text('Hapus'),
          ),
        ),
        context.gapH12,
        Expanded(
          child: ElevatedButton(
            onPressed: onSave,
            child: const Text('Simpan'),
          ),
        ),
      ],
    );
  }
}
