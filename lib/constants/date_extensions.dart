import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  bool isSameDay(DateTime date) {
    // if(date == null) return false;
    final dateFormat = DateFormat('yyyy-MM-dd');
    final date1 = dateFormat.format(this);
    final date2 = dateFormat.format(date);
    return date1 == date2;
  }

  // bool isBefore(DateTime date) {
  //   final now = DateTime.now();
  //   // final yesterday = DateTime(now.year, now.month, now.day - 1);
  //   final today = DateTime(now.year, now.month, now.day);
  //   return today.compareTo(date) < 0;
  // }

  // bool isToday(DateTime date) {
  //   final now = DateTime.now();
  //   final today = DateTime(now.year, now.month, now.day);
  //   final newDay = DateTime(date.year, date.month, date.day);
  //   return today.compareTo(newDay) == 0;
  // }

  // bool isFuture(DateTime date) {
  //   final now = DateTime.now();
  //   final tomorrow = DateTime(now.year, now.month, now.day + 1);
  //   return date.compareTo(tomorrow) > 0;
  // }
}
