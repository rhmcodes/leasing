import 'package:flutter/material.dart';

import '../../../../../core/constants/app_enum.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadow.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../data/models/inspection/inspection_photo_model.dart';
import '../../../../../shared/widgets/app_surface.dart';

class InspectionPhotoSection extends StatelessWidget {
  const InspectionPhotoSection({
    super.key,
    required this.photos,
    required this.onCapture,
  });

  final Map<InspectionPhotoType, InspectionPhotoModel> photos;
  final ValueChanged<InspectionPhotoType> onCapture;

  String _label(InspectionPhotoType type) {
    return switch (type) {
      InspectionPhotoType.front => 'Depan',
      InspectionPhotoType.back => 'Belakang',
      InspectionPhotoType.left => 'Kiri',
      InspectionPhotoType.right => 'Kanan',
      InspectionPhotoType.speedometer => 'Speedometer',
    };
  }

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Foto Kendaraan', style: Theme.of(context).textTheme.titleLarge),
          context.gapV4,
          Text(
            'Semua foto wajib dari kamera dan menyimpan GPS + waktu.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          context.gapV12,
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: AppSpacing.s12(context),
            mainAxisSpacing: AppSpacing.s12(context),
            childAspectRatio: 1.15,
            children:
                InspectionPhotoType.values.map((InspectionPhotoType type) {
              final InspectionPhotoModel? photo = photos[type];
              final bool hasPhoto = photo != null;
              final Color backgroundColor =
                  hasPhoto ? AppColors.successSoft : AppColors.infoSoft;
              final Color foregroundColor =
                  hasPhoto ? AppColors.success : AppColors.info;

              return Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: AppRadius.radiusLg(context),
                  boxShadow: AppShadows.card,
                ),
                child: Material(
                  color: AppColors.transparent,
                  borderRadius: AppRadius.radiusLg(context),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () => onCapture(type),
                    child: Padding(
                      padding: AppSpacing.v8(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            hasPhoto
                                ? Icons.check_circle
                                : Icons.camera_alt_outlined,
                            color: foregroundColor,
                          ),
                          context.gapV8,
                          Text(
                            _label(type),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: foregroundColor),
                          ),
                          if (hasPhoto) ...<Widget>[
                            context.gapV4,
                            Text(
                              'GPS + waktu tersimpan',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: foregroundColor),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
