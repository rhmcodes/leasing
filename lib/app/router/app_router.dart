import 'package:flutter/material.dart';

import '../modules/authentication/forgot/page/forgot_page.dart';
import '../modules/authentication/login/page/login_page.dart';
import '../modules/authentication/register/page/register_page.dart';
import '../modules/authentication/reset/page/reset_page.dart';
import '../modules/features/inspection/form/page/inspection_form_page.dart';
import '../modules/features/inspection/preview/page/inspection_preview_page.dart';
import '../modules/introduction/splash/page/splash_page.dart';
import '../modules/introduction/terms/page/terms_page.dart';
import '../modules/introduction/welcome/page/welcome_page.dart';
import '../modules/main/page/main_page.dart';
import 'app_routes.dart';
import 'app_transition.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Widget page = switch (settings.name) {
      AppRoutes.splash => const SplashPage(),
      AppRoutes.welcome => const WelcomePage(),
      AppRoutes.terms => const TermsPage(),
      AppRoutes.login => const LoginPage(),
      AppRoutes.register => const RegisterPage(),
      AppRoutes.forgot => const ForgotPage(),
      AppRoutes.reset => const ResetPage(),
      AppRoutes.main => const MainPage(),
      AppRoutes.inspectionForm => const InspectionFormPage(),
      AppRoutes.inspectionPreview => const InspectionPreviewPage(),
      _ => const SplashPage(),
    };

    return AppTransition.fade<dynamic>(
      page: page,
      settings: settings,
    );
  }
}
