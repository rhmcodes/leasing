import 'package:flutter/material.dart';

import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/widgets/app_surface.dart';
import '../../signature/widget/signature_canvas.dart';

class InspectionSignatureSection extends StatelessWidget {
  const InspectionSignatureSection({
    super.key,
    required this.signatureData,
    required this.onChanged,
    this.onDrawingStateChanged,
  });

  final String? signatureData;
  final ValueChanged<String?> onChanged;
  final ValueChanged<bool>? onDrawingStateChanged;

  @override
  Widget build(BuildContext context) {
    final bool hasSignature = signatureData != null && signatureData!.isNotEmpty;

    return AppSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Tanda Tangan Digital',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          context.gapV8,
          Text(
            hasSignature
                ? 'Tanda tangan sudah diisi.'
                : 'Silakan tanda tangan pada area di bawah.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          context.gapV12,
          SignatureCanvas(
            onChanged: onChanged,
            onClear: () => onChanged(null),
            onDrawingStateChanged: onDrawingStateChanged,
          ),
        ],
      ),
    );
  }
}
