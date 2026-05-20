import 'dart:async';

class AutosaveHelper {
  AutosaveHelper({
    this.delay = const Duration(seconds: 2),
  });

  final Duration delay;
  Timer? _timer;

  void schedule(Future<void> Function() save) {
    _timer?.cancel();
    _timer = Timer(delay, save);
  }

  void dispose() {
    _timer?.cancel();
  }
}
