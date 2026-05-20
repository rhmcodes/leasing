import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class InspectionCameraButton extends StatelessWidget {
  const InspectionCameraButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.completed = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        completed ? Icons.check_circle : Icons.camera_alt_outlined,
        color: completed ? AppColors.success : null,
      ),
      label: Text(label),
    );
  }
}
