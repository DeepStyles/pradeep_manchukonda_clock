import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:pradeep_manchukonda_clock/constants.dart';
import 'package:pradeep_manchukonda_clock/utilities/common_funcs.dart';

class TimeNotifier extends ChangeNotifier {
  String _minute = '';
  String _amOrpm = '';
  String _dayName = '';

  String _hour = '';
  Timer _timer;
  int _second = 0;
  ClockModel _model;

  TimeNotifier(ClockModel model) {
    _model = model;
    check24HourFormat(_model.is24HourFormat);
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      _setTime();
    });
    // _setTime();
  }

  String get hour => _hour;
  ClockModel get model => _model;
  int get second => _second;
  String get minute => _minute;

  String get dayName => _dayName;

  String get amOrpm => _amOrpm;

  void _setTime() {
    _minute = getTime('${Constants.strMins}');
    _amOrpm = getTime('${Constants.stramOrpm}');
    _dayName = getTime('${Constants.strDayName}');
    _second = DateTime.now().second + 1 == 60 ? 0 : DateTime.now().second + 1;
    _notify();
  }

  void check24HourFormat(bool hourFormat) {
    _hour = hourFormat
        ? getTime('${Constants.str24HourFormat}')
        : getTime('${Constants.str12HourFormat}');
  }

  void _notify() {
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _model.dispose();
    super.dispose();
  }
}
