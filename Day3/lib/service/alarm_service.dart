
import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class AlarmService {

  static final logger = Logger();

  static Timer setAlarm({required VoidCallback work, required Duration when, required int id}) {
    logger.d('Setting alarm at', when);
    logger.d('Id of the alarm', id);
    return Timer(
      when, work
    );
  }

  static void cancelAlarm({required int id}) {
    AndroidAlarmManager.cancel(id);
  }
}