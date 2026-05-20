import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AutosaveLocalDatasource {
  const AutosaveLocalDatasource();

  static const String _snapshotKey = 'inspection_form_snapshot';

  Future<void> saveSnapshot(Map<String, dynamic> json) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_snapshotKey, jsonEncode(json));
  }

  Future<Map<String, dynamic>?> getSnapshot() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? raw = prefs.getString(_snapshotKey);

    if (raw == null || raw.isEmpty) return null;

    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> clearSnapshot() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_snapshotKey);
  }
}
