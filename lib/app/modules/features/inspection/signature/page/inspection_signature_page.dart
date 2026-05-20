import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../shared/widgets/app_back_button.dart';
import '../../../../../shared/widgets/app_brand_header.dart';
import '../widget/signature_canvas.dart';

class InspectionSignaturePage extends StatefulWidget {
  const InspectionSignaturePage({super.key});

  @override
  State<InspectionSignaturePage> createState() => _InspectionSignaturePageState();
}

class _InspectionSignaturePageState extends State<InspectionSignaturePage> {
  String? _signatureData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.screenGradient),
        child: SafeArea(
          minimum: AppSpacing.screen(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Align(
                alignment: Alignment.centerLeft,
                child: AppBackButton(),
              ),
              context.gapV16,
              const AppBrandHeader(
                title: 'Tanda Tangan Digital',
                subtitle: 'Bubuhkan tanda tangan debitur secara langsung.',
                icon: Icons.draw_outlined,
              ),
              context.gapV24,
              Expanded(
                child: SignatureCanvas(
                  onChanged: (String value) =>
                      setState(() => _signatureData = value),
                  onClear: () => setState(() => _signatureData = null),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: AppSpacing.screen(context),
          child: ElevatedButton(
            onPressed: _signatureData == null
                ? null
                : () => Navigator.pop(context, _signatureData),
            child: const Text('Simpan Tanda Tangan'),
          ),
        ),
      ),
    );
  }
}
