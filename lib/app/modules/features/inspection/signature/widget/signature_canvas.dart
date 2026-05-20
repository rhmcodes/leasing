import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_shadow.dart';
import '../../../../../core/theme/app_spacing.dart';

class SignatureCanvas extends StatefulWidget {
  const SignatureCanvas({
    super.key,
    required this.onChanged,
    required this.onClear,
    this.onDrawingStateChanged,
    this.height = 260,
  });

  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final ValueChanged<bool>? onDrawingStateChanged;
  final double height;

  @override
  State<SignatureCanvas> createState() => _SignatureCanvasState();
}

class _SignatureCanvasState extends State<SignatureCanvas> {
  final List<Offset?> _points = <Offset?>[];
  int? _activePointer;

  String _serializePoints() {
    return _points
        .map((Offset? point) {
          if (point == null) return 'break';
          return '${point.dx.toStringAsFixed(2)},${point.dy.toStringAsFixed(2)}';
        })
        .join('|');
  }

  Offset _boundPoint(Offset point, Size size) {
    return Offset(
      point.dx.clamp(0, size.width).toDouble(),
      point.dy.clamp(0, size.height).toDouble(),
    );
  }

  void _startStroke(PointerDownEvent event, Size size) {
    if (_activePointer != null) return;

    _activePointer = event.pointer;
    widget.onDrawingStateChanged?.call(true);

    setState(() {
      if (_points.isNotEmpty && _points.last != null) _points.add(null);
      _points.add(_boundPoint(event.localPosition, size));
    });
    widget.onChanged(_serializePoints());
  }

  void _addPoint(PointerMoveEvent event, Size size) {
    if (event.pointer != _activePointer) return;

    setState(() => _points.add(_boundPoint(event.localPosition, size)));
    widget.onChanged(_serializePoints());
  }

  void _endStroke(int pointer) {
    if (pointer != _activePointer) return;

    _activePointer = null;
    widget.onDrawingStateChanged?.call(false);

    setState(() {
      if (_points.isNotEmpty && _points.last != null) _points.add(null);
    });
    widget.onChanged(_serializePoints());
  }

  void _cancelStroke() {
    if (_activePointer == null) return;

    _activePointer = null;
    widget.onDrawingStateChanged?.call(false);
  }

  void _clear() {
    _cancelStroke();
    setState(() => _points.clear());
    widget.onClear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: AppShadows.card,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final Size size = Size(
                  constraints.maxWidth,
                  constraints.maxHeight,
                );

                return Listener(
                  behavior: HitTestBehavior.opaque,
                  onPointerDown: (PointerDownEvent event) {
                    _startStroke(event, size);
                  },
                  onPointerMove: (PointerMoveEvent event) {
                    _addPoint(event, size);
                  },
                  onPointerUp: (PointerUpEvent event) {
                    _endStroke(event.pointer);
                  },
                  onPointerCancel: (_) => _cancelStroke(),
                  child: CustomPaint(
                    painter: _SignaturePainter(
                      List<Offset?>.unmodifiable(_points),
                    ),
                    size: Size.infinite,
                  ),
                );
              },
            ),
          ),
        ),
        context.gapV8,
        Align(
          alignment: Alignment.centerRight,
          child: TextButton.icon(
            onPressed: _clear,
            icon: const Icon(Icons.delete_outline),
            label: const Text('Hapus'),
          ),
        ),
      ],
    );
  }
}

class _SignaturePainter extends CustomPainter {
  const _SignaturePainter(this.points);

  final List<Offset?> points;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.textPrimary
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true
      ..strokeWidth = 3;

    for (int i = 0; i < points.length - 1; i++) {
      final Offset? current = points[i];
      final Offset? next = points[i + 1];

      if (current != null && next != null) {
        canvas.drawLine(current, next, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SignaturePainter oldDelegate) {
    return oldDelegate.points.length != points.length;
  }
}
