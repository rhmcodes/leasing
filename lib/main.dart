import 'package:flutter/material.dart';

import 'app/core/theme/app_theme.dart';
import 'app/router/app_router.dart';
import 'app/router/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NSSLeasing());
}

class NSSLeasing extends StatelessWidget {
  const NSSLeasing({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NSS Leasing Inspection',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}