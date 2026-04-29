String formatDateTime(DateTime value) {
  final day = value.day.toString().padLeft(2, '0');
  final month = value.month.toString().padLeft(2, '0');
  final year = value.year.toString();
  final hour = value.hour.toString().padLeft(2, '0');
  final minute = value.minute.toString().padLeft(2, '0');
  final second = value.second.toString().padLeft(2, '0');

  return '$day/$month/$year $hour:$minute:$second';
}

String formatBytes(int bytes) {
  if (bytes < 1024) {
    return '$bytes B';
  }

  final kilobytes = bytes / 1024;
  if (kilobytes < 1024) {
    return '${kilobytes.toStringAsFixed(1)} KB';
  }

  final megabytes = kilobytes / 1024;
  return '${megabytes.toStringAsFixed(2)} MB';
}
