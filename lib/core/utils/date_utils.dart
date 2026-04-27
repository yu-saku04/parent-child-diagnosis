import 'package:intl/intl.dart';

class AppDateUtils {
  static String formatDate(DateTime date) =>
      DateFormat('yyyy年M月d日').format(date);

  static String formatDateTime(DateTime date) =>
      DateFormat('yyyy年M月d日 HH:mm').format(date);

  static String formatShortDate(DateTime date) =>
      DateFormat('M月d日').format(date);

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
