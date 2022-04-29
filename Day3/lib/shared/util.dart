import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class Util {

  static final logger = Logger();

  static String parseDateTimeToString(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);// 2016-01-25
  }
  
  static parseStringDateTime(String date) {
    return DateFormat('yyyy-MM-dd').parse(date);
  }

  static String parseTimeOfDayToString(TimeOfDay time) {
    return '${time.hour}:${time.minute} ${time.period.name.toUpperCase()}';
  }

  static DateTime convert12HrTo24(String time) {
    TimeOfDay tod = parseStringToTimeOfDay(time);
    final now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    return date;
  }

  static TimeOfDay parseStringToTimeOfDay(String time) {
    if (time.contains('AM') || time.contains('PM')) {
      time = time.substring(0, time.length - 2);
    }
    return TimeOfDay(hour:int.parse(time.split(":")[0]),minute: int.parse(time.split(":")[1]));
  }


  static DateTime mergeTimeAndDate(String date, String time) {
    time = time.substring(0, time.length - 2);
    String string = date + " " + time;
    logger.d("merged String", string);
    DateTime convertedDate = DateFormat('yyyy-MM-dd hh:mm').parse(string);
    return convertedDate;
  }
}