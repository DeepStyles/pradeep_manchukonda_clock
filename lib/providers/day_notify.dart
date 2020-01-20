import 'package:flutter/material.dart';
import 'package:pradeep_manchukonda_clock/utilities/common_funcs.dart';

class DayNameNotifier extends ChangeNotifier {
  String _dayName = '';

  DayNameNotifier() : _dayName = '${getTime('EEEE')}';

  String get getDayName => _dayName;
  void reload(String day) {
    _dayName = day;
    notifyListeners();
  }
}
