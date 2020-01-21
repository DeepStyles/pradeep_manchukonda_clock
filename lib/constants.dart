import 'package:flutter/material.dart';

class Constants {
  ///colors for weekdays
  static const Map<String, Color> colorMap = {
    'mondayTop': Color(0xFF5FFAE0),
    'mondayBottom': Color(0xFFC22ED0),
    'tuesdayTop': Color(0xFFF6EA41),
    'tuesdayBottom': Color(0xFFF048C6),
    'wednesdayTop': Color(0xFFE3FF73),
    'wednesdayBottom': Color(0xFFE27C39),
    'thursdayTop': Color(0xFF0CCDA3),
    'thursdayBottom': Color(0xFFC1FCD3),
    'fridayTop': Color(0xFF07A3B2),
    'fridayBottom': Color(0xFFD9ECC7),
    'saturdayTop': Color(0xFFEAD6EE),
    'saturdayBottom': Color(0xFFA0F1EA),
    'sundayTop': Color(0xFFfd1d1d),
    'sundayBottom': Color(0xFF833ab4)
  };

  static const semanticClockTime = 'Clock Time';
  static const semanticDayName = 'Whats Today?';
  static const str12HourFormat = 'hh';
  static const str24HourFormat = 'HH';
  static const strMins = 'mm';
  static const stramOrpm = 'a';
  static const strDayName = 'EEEE';

  ///asset path for Flare file
  static const assetPath = 'assets/flare/clock_comp.flr';
  static const whiteColor = Colors.white;
  static const scaleDur = Duration(seconds: 3);
  static const secDur = Duration(milliseconds: 700);

  static const curveBounce = Curves.bounceOut;
  static const durOne = Duration(seconds: 1);

  static const durThree = Duration(seconds: 3);
  static const cAlign = Alignment.center;
  static const tcAlign = Alignment.topCenter;
  static const bcAlign = Alignment.bottomCenter;
}
