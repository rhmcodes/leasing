import '../../core/utils/date_formatter.dart';

extension DateExtension on DateTime {
  String get formattedDateTime => DateFormatter.dateTime(this);
}
