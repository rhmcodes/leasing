import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/signature_point.dart';

class SignaturePad extends StatefulWidget {
  const SignaturePad({
    super.key,
    required this.initialPoints,
    required this.onChanged,
    this.errorText,
  });

  final List<SignaturePoint> initialPoints;
  final ValueChanged<List<SignaturePoint>> onChanged;
  final String? errorText;

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  late List<Offset?> _points;

  @override
  void initState() {
    super.initState();
    _points = _fromSignature(widget.initialPoints);
  }

  @override
  void didUpdateWidget(covariant SignaturePad oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.initialPoints, widget.initialPoints)) {
      _points = _fromSignature(widget.initialPoints);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = widget.errorText == null
        ? theme.colorScheme.outlineVariant
        : theme.colorScheme.error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 220,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFDFEFE), Color(0xFFF3F8F8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withAlpha(10),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: RepaintBoundary(
                  child: CustomPaint(
                    painter: _SignaturePainter(points: _points),
                  ),
                ),
              ),
              Positioned.fill(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanStart: (details) {
                    setState(() {
                      _points = List<Offset?>.from(_points)
                        ..add(details.localPosition);
                    });
                  },
                  onPanUpdate: (details) {
                    setState(() {
                      _points = List<Offset?>.from(_points)
                        ..add(details.localPosition);
                    });
                  },
                  onPanEnd: (_) {
                    setState(() {
                      _points = List<Offset?>.from(_points)..add(null);
                    });
                    widget.onChanged(_toSignature(_points));
                  },
                ),
              ),
              if (_points.isEmpty)
                Positioned.fill(
                  child: IgnorePointer(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withAlpha(18),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.draw_outlined,
                              color: theme.colorScheme.primary,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Mulai tanda tangan',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: const Color(0xFF173F5F),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Gunakan jari atau stylus pada area kosong ini',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: 12,
                top: 12,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(220),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: borderColor.withAlpha(110)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Text(
                      'Area tanda tangan',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: const Color(0xFF173F5F),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _points = <Offset?>[];
                    });
                    widget.onChanged(const <SignaturePoint>[]);
                  },
                  icon: const Icon(Icons.cleaning_services_outlined),
                  label: const Text('Ulangi'),
                ),
              ),
              Positioned(
                left: 14,
                right: 14,
                bottom: 12,
                child: IgnorePointer(
                  child: Text(
                    'Tanda tangan akan ikut tersimpan dalam draft autosave.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: 6),
          Text(
            widget.errorText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }

  List<Offset?> _fromSignature(List<SignaturePoint> points) {
    return points
        .map((point) => point.isBreak ? null : Offset(point.x!, point.y!))
        .toList(growable: true);
  }

  List<SignaturePoint> _toSignature(List<Offset?> points) {
    return points
        .map(
          (point) => point == null
              ? const SignaturePoint.breakPoint()
              : SignaturePoint(x: point.dx, y: point.dy),
        )
        .toList(growable: false);
  }
}

class _SignaturePainter extends CustomPainter {
  const _SignaturePainter({required this.points});

  final List<Offset?> points;

  @override
  void paint(Canvas canvas, Size size) {
    final accentPaint = Paint()
      ..color = const Color(0xFF0D5C63).withAlpha(12)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final accentPath = Path()
      ..moveTo(18, size.height * 0.72)
      ..quadraticBezierTo(
        size.width * 0.28,
        size.height * 0.58,
        size.width * 0.42,
        size.height * 0.7,
      )
      ..quadraticBezierTo(
        size.width * 0.58,
        size.height * 0.84,
        size.width - 18,
        size.height * 0.66,
      );
    canvas.drawPath(accentPath, accentPaint);

    final paint = Paint()
      ..color = const Color(0xFF173F5F)
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = 3.2
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      if (current == null || next == null) {
        continue;
      }

      canvas.drawLine(current, next, paint);
    }

    if (points.isNotEmpty && points.last != null) {
      canvas.drawCircle(
        points.last!,
        math.max(1.4, paint.strokeWidth / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SignaturePainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
