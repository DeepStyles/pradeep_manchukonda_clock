import 'dart:math';

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
    final rectColorPaint = Paint()
      ..filterQuality = FilterQuality.high
      ..isAntiAlias = true
      ..color = secColor
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 1.0);

    final rectWhitePaint = Paint()
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high
      ..color = Colors.white
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 5
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

    final circlep = Paint()
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high
      ..color = primColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 1.0);

    final circlep1 = Paint()
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high
      ..color = secColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 1.0);

    final center = (Offset.zero & size).center;

    canvas.drawCircle(center, midCirRad, circlep);
    canvas.drawCircle(center, dotCirRad, circlep1);

    canvas.rotate(-pi / 2);
    canvas.save();
    for (var i = 0; i < 60; i++) {
      canvas.drawArc(
          Rect.fromCircle(center: center, radius: secondsCirRad),
          i * pi / 30,
          pi / 30,
          false,
          i == second ? rectColorPaint : rectWhitePaint);
    }

    canvas.rotate(-pi / 60);
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
