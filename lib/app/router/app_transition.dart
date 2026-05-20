import 'package:flutter/material.dart';

class AppTransition {
  const AppTransition._();

  static PageRouteBuilder<T> fade<T>({
    required Widget page,
    required RouteSettings settings,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
