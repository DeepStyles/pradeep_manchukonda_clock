import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:pradeep_manchukonda_clock/constants.dart';
import 'package:pradeep_manchukonda_clock/utilities/common_funcs.dart';

class TimeNotifier extends ChangeNotifier {
  TimeNotifier(ClockModel model) {
    _model = model;
    check24HourFormat(_model.is24HourFormat);
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      _setTime();
    });
    // _setTime();
  }

  Color gradBottomColor = Constants.colorMap['mondayBottom'];
  Color gradTopColor = Constants.colorMap['mondayTop'];

  String _amOrpm = '';
  String _dayName = '';
  String _hour = '';
  String _minute = '';
  ClockModel _model;
  int _second = 0;
  Timer _timer;

  String get hour => _hour;

  ClockModel get model => _model;

  int get second => _second;

  String get minute => _minute;

  String get dayName => _dayName;

  String get amOrpm => _amOrpm;

  void reload(String day) {
    _dayName = day;
    _notify();
  }

  void _setTime() {
    final _now = DateTime.now();

    check24HourFormat(_model.is24HourFormat);

    _minute = getTime('${Constants.strMins}');
    _amOrpm = getTime('${Constants.stramOrpm}');
    _dayName = getTime('${Constants.strDayName}');

    /// assigning colors for today
    gradTopColor = Constants.colorMap['${_dayName.toLowerCase()}Top'];
    gradBottomColor = Constants.colorMap['${dayName.toLowerCase()}Bottom'];

    ///due to animation of second text, we lag 1 sec, so I added plus 1
    _second = _now.second + 1 == 60 ? 0 : _now.second + 1;
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
