import 'package:flutter/material.dart';

class Constants {
  static const Map<String, Color> colorMap = {
    'mondayTop': Color(0xFF5FFAE0),
    'mondayBottom': Color(0xFFC22ED0),
    'tuesdayTop': Color(0xFFF6EA41),
    'tuesdayBottom': Color(0xFFF048C6),
    'wednesdayTop': Color(0xFFE3FF73),
    'wednesdayBottom': Color(0xFFE27C39),
    'thursdayTop': Color(0xFFA96F44),
    'thursdayBottom': Color(0xFFF2ECB6),
    'fridayTop': Color(0xFF07A3B2),
    'fridayBottom': Color(0xFFD9ECC7),
    'saturdayTop': Color(0xFFEAD6EE),
    'saturdayBottom': Color(0xFFA0F1EA),
    'sundayTop': Color(0xFFfd1d1d),
    'sundayBottom': Color(0xFF833ab4)
  };

  static const semanticClockTime = 'Clock Time';
  static const semanticDayName = 'Whats Today?';

  static const assetPath = 'assets/clock_comp.flr';
  static const whiteColor = Colors.white;
  static const scaleDur = Duration(seconds: 3);

  static const curveBounce = Curves.bounceOut;

  static const cAlign = Alignment.center;
  static const tcAlign = Alignment.topCenter;
  static const bcAlign = Alignment.bottomCenter;
}
