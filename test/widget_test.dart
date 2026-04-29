import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:reasing/app/app.dart';

void main() {
  testWidgets('inspection form renders key sections', (tester) async {
    SharedPreferences.setMockInitialValues(<String, Object>{});

    await tester.pumpWidget(const InspectionApp());
    await tester.pumpAndSettle();

    expect(find.text('Inspeksi Kendaraan Leasing'), findsOneWidget);
    expect(find.text('Identitas Inspeksi'), findsOneWidget);
    expect(find.text('Nomor Polisi'), findsOneWidget);
    expect(find.text('Kilometer'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Tanda Tangan Digital'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    expect(find.text('Tanda Tangan Digital'), findsOneWidget);
    expect(find.text('Submit Form Dummy'), findsOneWidget);
  });
}
