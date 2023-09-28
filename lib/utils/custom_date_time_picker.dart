import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDateTimePicker {
  static Future<String?> displayTimePicker(BuildContext context) async {
    var time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      return changeTimeFormat(time);
    } else {
      return null;
    }
  }

  static Future<String> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      return changeDateFormat(picked);
    } else {
      return '';
    }
  }

  static Future<String> selectBookingDate(BuildContext context) async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year, now.month, now.day),
      firstDate: DateTime(now.year, now.month, now.day),
      lastDate: DateTime(2101),
      selectableDayPredicate: (DateTime val) {
        return !dateComparision([], val);
      },
    );

    if (picked != null) {
      return changeDateFormat(picked);
    } else {
      return '';
    }
  }

  static bool areSameDay(DateTime one, DateTime two) {
    return one.day == two.day && one.month == two.month && one.year == two.year;
  }

  static bool dateComparision(List<DateTime> dates, DateTime targetDate) {
    try {
      dates.firstWhere((date) => areSameDay(date, targetDate));
      return true;
    } catch (_) {
      return false;
    }
  }

  static List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(DateTime.parse(
          DateFormat("yyyy-MM-dd").format(startDate.add(Duration(days: i)))));
    }
    return days;
  }

  static bool reservedDateExistInRange(
      List<DateTime> unAvailableDates, List<DateTime> selectedRange) {
    return unAvailableDates
        .toSet()
        .intersection(selectedRange.toSet())
        .isNotEmpty;
  }

  static String changeDateFormat(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(date);
    debugPrint(formatted); // something like 2013-04-20
    return formatted;
  }

  static String changeTimeFormat(TimeOfDay time) {
    DateTime now = DateTime.now();
    DateTime dt =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final DateFormat formatter = DateFormat.jm();
    final String formatted = formatter.format(dt);
    debugPrint(formatted); // something like 2013-04-20
    return formatted;
  }
}

String changeDateFormat(String inputDate) {
  return DateFormat("yyyy-MM-dd'T'00:00:00.000")
      .format(DateFormat('dd/MM/yyyy').parse(inputDate));
}
