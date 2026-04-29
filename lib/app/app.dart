import 'package:flutter/material.dart';

import '../features/inspection/data/repositories/local_inspection_repository.dart';
import '../features/inspection/presentation/pages/inspection_form_page.dart';
import 'theme/app_theme.dart';

class InspectionApp extends StatelessWidget {
  const InspectionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Inspeksi Kendaraan',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: InspectionFormPage(repository: LocalInspectionRepository()),
    );
  }
}
