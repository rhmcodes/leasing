import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadow.dart';
import '../../core/theme/app_spacing.dart';
import 'app_back_button.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.padding,
    this.scrollable = false,
    this.showTitle = true,
    this.showBackButton = false,
    this.onBackPressed,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final EdgeInsetsGeometry? padding;
  final bool scrollable;
  final bool showTitle;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    final Widget titleSurface = Container(
      padding: AppSpacing.card(context),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.radiusLg(context),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: AppRadius.radiusMd(context),
            ),
            child: const Icon(
              Icons.layers_outlined,
              color: AppColors.primary,
            ),
          ),
          context.gapH12,
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          if (actions != null) ...actions!,
        ],
      ),
    );

    final Widget content = Padding(
      padding: padding ?? AppSpacing.screen(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (showTitle || showBackButton) ...<Widget>[
            if (showTitle)
              Row(
                children: <Widget>[
                  if (showBackButton) ...<Widget>[
                    AppBackButton(onPressed: onBackPressed),
                    context.gapH12,
                  ],
                  Expanded(child: titleSurface),
                ],
              )
            else
              Align(
                alignment: Alignment.centerLeft,
                child: AppBackButton(onPressed: onBackPressed),
              ),
            context.gapV20,
          ],
          body,
        ],
      ),
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.screenGradient),
        child: SafeArea(
          child: scrollable
              ? ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[content],
                )
              : content,
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar == null
          ? null
          : SafeArea(
              top: false,
              child: bottomNavigationBar!,
            ),
    );
  }
}
