import 'dart:math' as math;

import 'package:flutter/material.dart';

extension AppResponsive on BuildContext {
  double res(double value) {
    final double width = MediaQuery.sizeOf(this).width;
    final double factor = (width / 390).clamp(0.92, 1.12).toDouble();
    return math.max(0.0, value * factor);
  }
}
