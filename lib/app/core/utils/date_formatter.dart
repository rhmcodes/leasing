import 'package:intl/intl.dart';

class DateFormatter {
  const DateFormatter._();

  static String dateTime(DateTime value) {
    return DateFormat('dd MMM yyyy, HH:mm').format(value);
  }

  static String iso(DateTime value) => value.toIso8601String();
}
