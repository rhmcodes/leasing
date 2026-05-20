import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/app_info_tile.dart';

class InspectionPhotoCard extends StatelessWidget {
  const InspectionPhotoCard({
    super.key,
    required this.title,
    required this.hasPhoto,
  });

  final String title;
  final bool hasPhoto;

  @override
  Widget build(BuildContext context) {
    return AppInfoTile(
      icon: hasPhoto ? Icons.check_circle : Icons.camera_alt_outlined,
      iconColor: hasPhoto ? AppColors.success : AppColors.textSecondary,
      iconBackground: hasPhoto ? AppColors.successSoft : AppColors.surfaceMuted,
      title: title,
      subtitle: hasPhoto ? 'Foto sudah tersimpan.' : 'Foto belum tersedia.',
    );
  }
}
