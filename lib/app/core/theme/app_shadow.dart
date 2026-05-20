import 'package:flutter/material.dart';

/// Reusable shadow presets for consistent elevation.
class AppShadows {
  const AppShadows._();

  static const List<BoxShadow> none = <BoxShadow>[];

  static const List<BoxShadow> card = <BoxShadow>[
    BoxShadow(color: Color(0x0D0F172A), blurRadius: 14, offset: Offset(0, 6)),
    BoxShadow(color: Color(0x08D90429), blurRadius: 8, offset: Offset(0, 2)),
  ];

  static const List<BoxShadow> cardMedium = <BoxShadow>[
    BoxShadow(color: Color(0x120F172A), blurRadius: 20, offset: Offset(0, 10)),
    BoxShadow(color: Color(0x0AD90429), blurRadius: 10, offset: Offset(0, 3)),
  ];

  static const List<BoxShadow> elevated = <BoxShadow>[
    BoxShadow(color: Color(0x18D90429), blurRadius: 18, offset: Offset(0, 8)),
  ];

  static const List<BoxShadow> button = <BoxShadow>[
    BoxShadow(color: Color(0x18D90429), blurRadius: 12, offset: Offset(0, 5)),
  ];

  static const List<BoxShadow> buttonPressed = <BoxShadow>[
    BoxShadow(color: Color(0x0FD90429), blurRadius: 6, offset: Offset(0, 2)),
  ];

  static const List<BoxShadow> modal = <BoxShadow>[
    BoxShadow(color: Color(0x1F0F172A), blurRadius: 28, offset: Offset(0, 16)),
    BoxShadow(color: Color(0x0DD90429), blurRadius: 10, offset: Offset(0, 3)),
  ];

  static const List<BoxShadow> bottomSheet = <BoxShadow>[
    BoxShadow(color: Color(0x140F172A), blurRadius: 20, offset: Offset(0, -6)),
  ];

  static const List<BoxShadow> glass = <BoxShadow>[
    BoxShadow(color: Color(0x337F0018), blurRadius: 30, offset: Offset(0, 14)),
    BoxShadow(
      color: Color(0x26FFFFFF),
      blurRadius: 10,
      offset: Offset(-4, -4),
      spreadRadius: -7,
    ),
  ];
}
