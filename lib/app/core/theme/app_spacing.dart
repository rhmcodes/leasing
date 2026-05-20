import 'package:flutter/material.dart';

import '../utils/app_responsive.dart';

/// Responsive spacing tokens based on a 390px design width.
class AppSpacing {
  const AppSpacing._();

  // ---------------------------------------------------------------------------
  // Raw responsive spacing tokens
  // ---------------------------------------------------------------------------
  static double value(BuildContext context, double value) => context.res(value);

  static double s4(BuildContext c) => value(c, 4);
  static double s6(BuildContext c) => value(c, 6);
  static double s8(BuildContext c) => value(c, 8);
  static double s10(BuildContext c) => value(c, 10);
  static double s12(BuildContext c) => value(c, 12);
  static double s14(BuildContext c) => value(c, 14);
  static double s16(BuildContext c) => value(c, 16);
  static double s18(BuildContext c) => value(c, 18);
  static double s20(BuildContext c) => value(c, 20);
  static double s24(BuildContext c) => value(c, 24);
  static double s26(BuildContext c) => value(c, 26);
  static double s28(BuildContext c) => value(c, 28);
  static double s32(BuildContext c) => value(c, 32);
  static double s36(BuildContext c) => value(c, 36);
  static double s40(BuildContext c) => value(c, 40);
  static double s48(BuildContext c) => value(c, 48);
  static double s60(BuildContext c) => value(c, 60);
  static double s80(BuildContext c) => value(c, 80);
  static double s100(BuildContext c) => value(c, 100);
  static double s120(BuildContext c) => value(c, 120);
  static double s140(BuildContext c) => value(c, 140);
  static double s160(BuildContext c) => value(c, 160);
  static double s180(BuildContext c) => value(c, 180);
  static double s200(BuildContext c) => value(c, 200);

  // ---------------------------------------------------------------------------
  // Semantic non-responsive constants
  // ---------------------------------------------------------------------------
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double g = 28;
  static const double xl = 32;
  static const double xxl = 42;
  static const double xxxl = 48;

  // ---------------------------------------------------------------------------
  // EdgeInsets helpers
  // ---------------------------------------------------------------------------
  static EdgeInsets all(BuildContext c, double value) =>
      EdgeInsets.all(c.res(value));

  static EdgeInsets h(BuildContext c, double value) {
    return EdgeInsets.symmetric(horizontal: c.res(value));
  }

  static EdgeInsets v(BuildContext c, double value) {
    return EdgeInsets.symmetric(vertical: c.res(value));
  }

  static EdgeInsets symmetric(
    BuildContext c, {
    double horizontal = 0,
    double vertical = 0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: c.res(horizontal),
      vertical: c.res(vertical),
    );
  }

  static EdgeInsets only(
    BuildContext c, {
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      left: c.res(left),
      top: c.res(top),
      right: c.res(right),
      bottom: c.res(bottom),
    );
  }

  static EdgeInsets all4(BuildContext c) => all(c, 4);
  static EdgeInsets all6(BuildContext c) => all(c, 6);
  static EdgeInsets all8(BuildContext c) => all(c, 8);
  static EdgeInsets all12(BuildContext c) => all(c, 12);
  static EdgeInsets all16(BuildContext c) => all(c, 16);
  static EdgeInsets all20(BuildContext c) => all(c, 20);
  static EdgeInsets all24(BuildContext c) => all(c, 24);
  static EdgeInsets all32(BuildContext c) => all(c, 32);

  static EdgeInsets h4(BuildContext c) => h(c, 4);
  static EdgeInsets h6(BuildContext c) => h(c, 6);
  static EdgeInsets h8(BuildContext c) => h(c, 8);
  static EdgeInsets h12(BuildContext c) => h(c, 12);
  static EdgeInsets h16(BuildContext c) => h(c, 16);
  static EdgeInsets h20(BuildContext c) => h(c, 20);
  static EdgeInsets h24(BuildContext c) => h(c, 24);
  static EdgeInsets h32(BuildContext c) => h(c, 32);

  static EdgeInsets v4(BuildContext c) => v(c, 4);
  static EdgeInsets v6(BuildContext c) => v(c, 6);
  static EdgeInsets v8(BuildContext c) => v(c, 8);
  static EdgeInsets v12(BuildContext c) => v(c, 12);
  static EdgeInsets v16(BuildContext c) => v(c, 16);
  static EdgeInsets v20(BuildContext c) => v(c, 20);
  static EdgeInsets v24(BuildContext c) => v(c, 24);
  static EdgeInsets v32(BuildContext c) => v(c, 32);

  // ---------------------------------------------------------------------------
  // Semantic padding presets
  // ---------------------------------------------------------------------------
  static const EdgeInsets input = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 14,
  );

  static EdgeInsets screen(BuildContext c) =>
      only(c, left: 20, top: 20, right: 20, bottom: 24);

  static EdgeInsets feature(BuildContext c) =>
      only(c, left: 20, top: 24, right: 20, bottom: 28);

  static EdgeInsets card(BuildContext c) => all16(c);

  static EdgeInsets section(BuildContext c) =>
      symmetric(c, horizontal: 16, vertical: 60);
}

extension SpacingExt on BuildContext {
  // ---------------------------------------------------------------------------
  // Vertical gaps
  // ---------------------------------------------------------------------------
  Widget get gapV4 => SizedBox(height: s4);
  Widget get gapV6 => SizedBox(height: s6);
  Widget get gapV8 => SizedBox(height: s8);
  Widget get gapV10 => SizedBox(height: s10);
  Widget get gapV12 => SizedBox(height: s12);
  Widget get gapV14 => SizedBox(height: s14);
  Widget get gapV16 => SizedBox(height: s16);
  Widget get gapV18 => SizedBox(height: s18);
  Widget get gapV20 => SizedBox(height: s20);
  Widget get gapV24 => SizedBox(height: s24);
  Widget get gapV26 => SizedBox(height: s26);
  Widget get gapV28 => SizedBox(height: s28);
  Widget get gapV32 => SizedBox(height: s32);
  Widget get gapV36 => SizedBox(height: s36);
  Widget get gapV40 => SizedBox(height: s40);
  Widget get gapV48 => SizedBox(height: s48);
  Widget get gapV60 => SizedBox(height: s60);
  Widget get gapV80 => SizedBox(height: s80);
  Widget get gapV100 => SizedBox(height: s100);
  Widget get gapV120 => SizedBox(height: s120);
  Widget get gapV140 => SizedBox(height: s140);
  Widget get gapV160 => SizedBox(height: s160);
  Widget get gapV180 => SizedBox(height: s180);
  Widget get gapV200 => SizedBox(height: s200);

  // ---------------------------------------------------------------------------
  // Horizontal gaps
  // ---------------------------------------------------------------------------
  Widget get gapH4 => SizedBox(width: s4);
  Widget get gapH6 => SizedBox(width: s6);
  Widget get gapH8 => SizedBox(width: s8);
  Widget get gapH10 => SizedBox(width: s10);
  Widget get gapH12 => SizedBox(width: s12);
  Widget get gapH14 => SizedBox(width: s14);
  Widget get gapH16 => SizedBox(width: s16);
  Widget get gapH18 => SizedBox(width: s18);
  Widget get gapH20 => SizedBox(width: s20);
  Widget get gapH24 => SizedBox(width: s24);
  Widget get gapH26 => SizedBox(width: s26);
  Widget get gapH28 => SizedBox(width: s28);
  Widget get gapH32 => SizedBox(width: s32);
  Widget get gapH36 => SizedBox(width: s36);
  Widget get gapH40 => SizedBox(width: s40);
  Widget get gapH48 => SizedBox(width: s48);
  Widget get gapH60 => SizedBox(width: s60);
  Widget get gapH80 => SizedBox(width: s80);
  Widget get gapH100 => SizedBox(width: s100);
  Widget get gapH120 => SizedBox(width: s120);
  Widget get gapH140 => SizedBox(width: s140);
  Widget get gapH160 => SizedBox(width: s160);
  Widget get gapH180 => SizedBox(width: s180);
  Widget get gapH200 => SizedBox(width: s200);

  // ---------------------------------------------------------------------------
  // Padding shortcuts
  // ---------------------------------------------------------------------------
  EdgeInsets get pScreen => AppSpacing.screen(this);
  EdgeInsets get pFeature => AppSpacing.feature(this);
  EdgeInsets get pCard => AppSpacing.card(this);
  EdgeInsets get pSection => AppSpacing.section(this);

  EdgeInsets get p4 => AppSpacing.all4(this);
  EdgeInsets get p6 => AppSpacing.all6(this);
  EdgeInsets get p8 => AppSpacing.all8(this);
  EdgeInsets get p12 => AppSpacing.all12(this);
  EdgeInsets get p16 => AppSpacing.all16(this);
  EdgeInsets get p20 => AppSpacing.all20(this);
  EdgeInsets get p24 => AppSpacing.all24(this);
  EdgeInsets get p32 => AppSpacing.all32(this);

  EdgeInsets get px4 => AppSpacing.h4(this);
  EdgeInsets get px6 => AppSpacing.h6(this);
  EdgeInsets get px8 => AppSpacing.h8(this);
  EdgeInsets get px12 => AppSpacing.h12(this);
  EdgeInsets get px16 => AppSpacing.h16(this);
  EdgeInsets get px20 => AppSpacing.h20(this);
  EdgeInsets get px24 => AppSpacing.h24(this);
  EdgeInsets get px32 => AppSpacing.h32(this);

  EdgeInsets get py4 => AppSpacing.v4(this);
  EdgeInsets get py6 => AppSpacing.v6(this);
  EdgeInsets get py8 => AppSpacing.v8(this);
  EdgeInsets get py12 => AppSpacing.v12(this);
  EdgeInsets get py16 => AppSpacing.v16(this);
  EdgeInsets get py20 => AppSpacing.v20(this);
  EdgeInsets get py24 => AppSpacing.v24(this);
  EdgeInsets get py32 => AppSpacing.v32(this);

  // ---------------------------------------------------------------------------
  // Footer helpers
  // ---------------------------------------------------------------------------
  double get footerSvgHeight => res(60);
  double get footerBottomPadding => s24;
  double get footerArea => footerSvgHeight + footerBottomPadding;

  // ---------------------------------------------------------------------------
  // Raw responsive values
  // ---------------------------------------------------------------------------
  double get s4 => AppSpacing.s4(this);
  double get s6 => AppSpacing.s6(this);
  double get s8 => AppSpacing.s8(this);
  double get s10 => AppSpacing.s10(this);
  double get s12 => AppSpacing.s12(this);
  double get s14 => AppSpacing.s14(this);
  double get s16 => AppSpacing.s16(this);
  double get s18 => AppSpacing.s18(this);
  double get s20 => AppSpacing.s20(this);
  double get s24 => AppSpacing.s24(this);
  double get s26 => AppSpacing.s26(this);
  double get s28 => AppSpacing.s28(this);
  double get s32 => AppSpacing.s32(this);
  double get s36 => AppSpacing.s36(this);
  double get s40 => AppSpacing.s40(this);
  double get s48 => AppSpacing.s48(this);
  double get s60 => AppSpacing.s60(this);
  double get s80 => AppSpacing.s80(this);
  double get s100 => AppSpacing.s100(this);
  double get s120 => AppSpacing.s120(this);
  double get s140 => AppSpacing.s140(this);
  double get s160 => AppSpacing.s160(this);
  double get s180 => AppSpacing.s180(this);
  double get s200 => AppSpacing.s200(this);
}
