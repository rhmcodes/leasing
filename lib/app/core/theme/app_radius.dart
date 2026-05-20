import 'package:flutter/material.dart';

import '../utils/app_responsive.dart';

/// Responsive border radius tokens.
class AppRadius {
  const AppRadius._();

  static const double xs = 4;
  static const double sm = 10;
  static const double md = 14;
  static const double lg = 20;
  static const double xl = 28;
  static const double full = 999;

  static Radius r(BuildContext context, double value) {
    return Radius.circular(context.res(value));
  }

  static BorderRadius circular(BuildContext context, double value) {
    return BorderRadius.circular(context.res(value));
  }

  static BorderRadius radiusXs(BuildContext context) => circular(context, xs);

  static BorderRadius radiusSm(BuildContext context) => circular(context, sm);

  static BorderRadius radiusMd(BuildContext context) => circular(context, md);

  static BorderRadius radiusLg(BuildContext context) => circular(context, lg);

  static BorderRadius radiusXl(BuildContext context) => circular(context, xl);

  static BorderRadius radiusFull(BuildContext context) =>
      circular(context, full);
}
