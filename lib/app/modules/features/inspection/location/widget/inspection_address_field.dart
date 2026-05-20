import 'package:flutter/material.dart';

import '../../../../../shared/widgets/app_text_field.dart';

class InspectionAddressField extends StatelessWidget {
  const InspectionAddressField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: 'Keterangan Alamat',
    );
  }
}
