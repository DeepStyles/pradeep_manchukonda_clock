import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pradeep_manchukonda_clock/extensions.dart';

class DigiTalClockPaint extends CustomPainter {
  DigiTalClockPaint({this.index});

  final index;

  @override
  void paint(Canvas canvas, Size size) {
    final rectCirclePaint = Paint()
      ..filterQuality = FilterQuality.high
      ..isAntiAlias = true
      ..color = Color(0xFFFE1C2D)
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 1.0);

    final rectCirclePaint1 = Paint()
      // ..color = Color(0xFFC22ED0)
      ..color = Colors.white
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 1.0);

    final rectp = Paint()
      // ..color = Color(0xFFC22ED0)
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 1.0);

    final rectp1 = Paint()
      // ..color = Color(0xFFC22ED0)
      ..color = Color(0xFFFE1C2D)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 1.0);
    // Color(0xFFC22ED0)

    final circlep = Paint()
      // ..color = Color(0xFFC22ED0)
      ..color = Color(0xFFC22ED0)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 1.0);

    final circlep1 = Paint()
      // ..color = Color(0xFFC22ED0)
      ..color = Color(0xFF5FFAE0)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 1.0);

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 44, circlep);
    canvas.drawCircle(center, 40, circlep1);

    canvas.rotate(-pi / 2);
    canvas.save();
    for (var i = 0; i < 60; i++) {
      canvas.drawArc(Rect.fromCircle(center: center, radius: 52), i * pi / 30,
          pi / 30, false, i == index ? rectCirclePaint : rectCirclePaint1);
      // }
    }

    canvas.rotate(-pi / 60);
    for (int i = 0; i < 12; i++) {
      canvas.drawCircle(Offset(40, 0), 2,
          DateTime.now().getTwelveHourFormat() == i ? rectp1 : rectp);
      canvas.rotate(2 * pi / 12);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this.index != oldDelegate;
  }
}
