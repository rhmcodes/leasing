import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class SyncStatusBadge extends StatelessWidget {
  const SyncStatusBadge({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(Icons.cloud_done_outlined, color: AppColors.primary),
      label: Text(label),
    );
  }
}
