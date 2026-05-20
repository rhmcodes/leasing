import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/inspection/inspection_draft_model.dart';

class InspectionLocalDatasource {
  const InspectionLocalDatasource();

  static const String _latestDraftKey = 'latest_inspection_draft';

  Future<void> saveDraft(InspectionDraftModel draft) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_latestDraftKey, jsonEncode(draft.toJson()));
  }

  Future<InspectionDraftModel?> getLatestDraft() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? raw = prefs.getString(_latestDraftKey);

    if (raw == null || raw.isEmpty) return null;

    return InspectionDraftModel.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }

  Future<void> deleteLatestDraft() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_latestDraftKey);
  }
}
