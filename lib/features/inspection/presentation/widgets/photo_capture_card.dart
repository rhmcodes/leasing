import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../../app/utils/formatters.dart';
import '../../domain/entities/inspection_photo.dart';

class PhotoCaptureCard extends StatelessWidget {
  const PhotoCaptureCard({
    super.key,
    required this.category,
    required this.photo,
    required this.errorText,
    required this.onCapture,
    required this.onRemove,
  });

  final PhotoCategory category;
  final InspectionPhoto? photo;
  final String? errorText;
  final VoidCallback onCapture;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: errorText == null
              ? theme.colorScheme.outlineVariant
              : theme.colorScheme.error,
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(category.label, style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              category.helperText,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: CustomPaint(
                  painter: _PhotoPreviewPainter(
                    category: category,
                    photo: photo,
                    borderColor: theme.colorScheme.outlineVariant,
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (photo != null) ...[
              Text(
                'GPS ${photo!.metadata.latitude.toStringAsFixed(5)}, '
                '${photo!.metadata.longitude.toStringAsFixed(5)}',
                style: theme.textTheme.bodySmall,
              ),
              Text(
                'Timestamp ${formatDateTime(photo!.metadata.capturedAt)}',
                style: theme.textTheme.bodySmall,
              ),
              Text(
                'Ukuran ${formatBytes(photo!.metadata.originalSizeBytes)}'
                ' -> ${formatBytes(photo!.metadata.compressedSizeBytes)}',
                style: theme.textTheme.bodySmall,
              ),
              Text(
                'Mode ${photo!.metadata.storageMode}',
                style: theme.textTheme.bodySmall,
              ),
            ],
            if (errorText != null) ...[
              const SizedBox(height: 6),
              Text(
                errorText!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ],
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onCapture,
                    icon: const Icon(Icons.add_a_photo_outlined),
                    label: Text(photo == null ? 'Ambil Dummy' : 'Ambil Ulang'),
                  ),
                ),
                if (photo != null) ...[
                  const SizedBox(width: 8),
                  IconButton.filledTonal(
                    tooltip: 'Hapus foto',
                    onPressed: onRemove,
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoPreviewPainter extends CustomPainter {
  const _PhotoPreviewPainter({
    required this.category,
    required this.photo,
    required this.borderColor,
  });

  final PhotoCategory category;
  final InspectionPhoto? photo;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final radius = const Radius.circular(18);
    final rrect = RRect.fromRectAndRadius(rect, radius);
    final backgroundPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(size.width, size.height),
        photo == null
            ? <Color>[const Color(0xFFF1F5F9), const Color(0xFFE2E8F0)]
            : <Color>[
                Color(photo!.previewColorValue),
                Color(photo!.previewColorValue).withAlpha(170),
              ],
      );
    canvas.drawRRect(rrect, backgroundPaint);

    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = borderColor
      ..strokeWidth = 1;
    canvas.drawRRect(rrect, borderPaint);

    final titlePainter = TextPainter(
      text: TextSpan(
        text: photo == null ? 'Belum ada foto' : category.label,
        style: TextStyle(
          color: photo == null ? const Color(0xFF334155) : Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 2,
    )..layout(maxWidth: size.width - 24);
    titlePainter.paint(canvas, const Offset(12, 14));

    final subtitlePainter = TextPainter(
      text: TextSpan(
        text: photo == null
            ? 'Tekan tombol di bawah untuk membuat preview dummy.'
            : photo!.fileName,
        style: TextStyle(
          color: photo == null ? const Color(0xFF475569) : Colors.white,
          fontSize: 11,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 2,
      ellipsis: '...',
    )..layout(maxWidth: size.width - 24);
    subtitlePainter.paint(canvas, const Offset(12, 38));

    final framePaint = Paint()
      ..color = Colors.white.withAlpha(photo == null ? 90 : 40)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final frameRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(12, 72, size.width - 24, size.height - 96),
      const Radius.circular(16),
    );
    canvas.drawRRect(frameRect, framePaint);

    final watermarkPainter = TextPainter(
      text: TextSpan(
        text: photo == null
            ? 'GPS | timestamp belum tersedia'
            : photo!.metadata.watermarkText,
        style: TextStyle(
          color: photo == null ? const Color(0xFF64748B) : Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 2,
      ellipsis: '...',
    )..layout(maxWidth: size.width - 32);
    watermarkPainter.paint(canvas, Offset(16, size.height - 42));
  }

  @override
  bool shouldRepaint(covariant _PhotoPreviewPainter oldDelegate) {
    return oldDelegate.photo != photo ||
        oldDelegate.category != category ||
        oldDelegate.borderColor != borderColor;
  }
}
