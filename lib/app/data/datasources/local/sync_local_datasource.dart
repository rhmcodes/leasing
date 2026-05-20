import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/inspection/sync_queue_model.dart';

class SyncLocalDatasource {
  const SyncLocalDatasource();

  static const String _queueKey = 'inspection_sync_queue';

  Future<void> addToQueue(SyncQueueModel item) async {
    final List<SyncQueueModel> queue = await getQueue();
    queue.add(item);
    await _saveQueue(queue);
  }

  Future<List<SyncQueueModel>> getQueue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? raw = prefs.getString(_queueKey);

    if (raw == null || raw.isEmpty) return <SyncQueueModel>[];

    final List<dynamic> list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((item) => SyncQueueModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> _saveQueue(List<SyncQueueModel> queue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _queueKey,
      jsonEncode(queue.map((item) => item.toJson()).toList()),
    );
  }
}
