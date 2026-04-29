class SignaturePoint {
  const SignaturePoint({required this.x, required this.y});

  const SignaturePoint.breakPoint() : x = null, y = null;

  final double? x;
  final double? y;

  bool get isBreak => x == null || y == null;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'x': x, 'y': y};
  }

  factory SignaturePoint.fromJson(Map<String, dynamic> json) {
    final x = (json['x'] as num?)?.toDouble();
    final y = (json['y'] as num?)?.toDouble();
    if (x == null || y == null) {
      return const SignaturePoint.breakPoint();
    }

    return SignaturePoint(x: x, y: y);
  }
}
