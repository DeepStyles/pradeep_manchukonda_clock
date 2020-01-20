import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class DigiTalClockPaint extends CustomPainter {
  DigiTalClockPaint(
      {this.second,
      this.dotCirRad,
      this.midCirRad,
      this.secondsCirRad,
      this.primColor,
      this.secColor})
      : assert(second != null),
        assert(dotCirRad != null),
        assert(midCirRad != null),
        assert(primColor != null),
        assert(secColor != null),
        assert(secondsCirRad != null),
        assert(second >= 0 && second < 60),
        assert(dotCirRad > 0 && midCirRad > 0 && secondsCirRad > 0),
        assert(
            primColor != Colors.transparent && secColor != Colors.transparent);

  int second;
  double secondsCirRad;
  double midCirRad;
  double dotCirRad;
  Color primColor;
  Color secColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;

    final rectColorPaint = Paint()
      ..filterQuality = FilterQuality.high
      ..isAntiAlias = true
      ..color = primColor
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1.0);

    final rectWhitePaint = Paint()
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high
      ..color = Colors.white
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 1.0);

    final hourCircleWhitePaint = Paint()
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.5
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 1.0);

    final medCirclep = Paint()
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high
      ..color = primColor
      ..shader = SweepGradient(
        colors: [
          secColor.withOpacity(0.2),
          secColor,
        ],
        startAngle: -pi / 2,
        endAngle: 2 * pi,
      ).createShader(Rect.fromCircle(
        center: center,
        radius: midCirRad,
      ))
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 1.0);

    final smallCirclep = Paint()
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high
      ..color = primColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 1.0);
    // final smallCirclep1 = Paint()
    //   ..isAntiAlias = true
    //   ..filterQuality = FilterQuality.high
    //   ..color = Color(0xFF060D29)
    //   ..strokeWidth = 1
    // ..shader =
    //   ..style = PaintingStyle.fill
    //   ..maskFilter = MaskFilter.blur(BlurStyle.normal, 1.0);

    // canvas.drawCircle(center, midCirRad, medCirclep);
    canvas.drawArc(Rect.fromCircle(center: center, radius: midCirRad), -pi / 2,
        2 * pi, false, medCirclep);

    canvas.drawCircle(center, dotCirRad, smallCirclep);
    // canvas.drawCircle(center, dotCirRad - 5, smallCirclep1);
    // canvas.drawShadow()

    canvas.rotate(-pi / 2 - pi / 60);
    canvas.save();
    for (var i = 0; i < 60; i++) {
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: secondsCirRad),
          i * pi / 30,
          pi / 30,
          false,
          i == second ? rectColorPaint : rectWhitePaint);
    }

    canvas.rotate(pi / 60);
    for (int i = 0; i < 12; i++) {
      canvas.drawCircle(Offset(dotCirRad, 0), 2, hourCircleWhitePaint);
      canvas.rotate(2 * pi / 12);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(DigiTalClockPaint oldDelegate) {
    return oldDelegate.second != second;
  }
}
