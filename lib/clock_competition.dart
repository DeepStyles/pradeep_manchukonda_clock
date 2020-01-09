import 'dart:async';
import 'dart:core';
import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' show radians;

class ClockCompetition extends StatefulWidget {
  @override
  _ClockCompetitionState createState() => _ClockCompetitionState();
}

class _ClockCompetitionState extends State<ClockCompetition>
    with TickerProviderStateMixin {
  AnimationController cont1;
  AnimationController cont2;
  Animation<double> secRotate;
  Animation<double> negsecRotate;
  Animation<double> radiusInOut;
  Animation<double> sizeInc;

  double rotate;

  @override
  void initState() {
    rotate = pi / 12;
    cont2 = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
        reverseDuration: Duration(seconds: 1));

    cont1 = AnimationController(vsync: this, duration: Duration(seconds: 1));
    secRotate = Tween<double>(begin: 0, end: pi / 4)
        .animate(CurvedAnimation(parent: cont1, curve: Curves.ease));

    radiusInOut = Tween<double>(begin: 122, end: 128).animate(CurvedAnimation(
        parent: cont2,
        curve: Curves.bounceOut,
        reverseCurve: Curves.bounceOut));
    sizeInc = Tween<double>(begin: 0, end: 1.5)
        .animate(CurvedAnimation(parent: cont2, curve: Curves.bounceOut));

    // cont1 = AnimationController(vsync: this, duration: Duration(seconds: 1));
    // negsecRotate = Tween<double>(begin: 0, end: -pi / 16)
    //     .animate(CurvedAnimation(parent: cont1, curve: Curves.ease));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final animeConts = Provider.of<AnimeContNotifier>(context, listen: false);
      // animeConts.init(contF, contB);
      // Timer.periodic(Duration(seconds: 1), (t) {
      cont2.repeat();
      cont1.repeat();
      // });
    });

    super.initState();
  }

  @override
  void dispose() {
    cont2.stop();

    cont2.dispose();

    cont1.stop();

    cont1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('${MediaQuery.of(context).size}');
    return Container(
      width: 800,
      height: 480,
      color: Colors.black87,
      child: Stack(
        children: <Widget>[
          // FlareLoading(
          //   fit: BoxFit.cover,
          //   // key: Key('flareWidgetKey'),
          //   alignment: Alignment.center,
          //   name: 'assets/clock_comp_impl.flr',
          //   // name: 'assets/Spaceman_inner_sahdow.flr',
          //   // startAnimation: 'animate',
          //   // loopAnimation: 'animate',
          //   onSuccess: (data) {},
          //   onError: (error, stacktrace) {},
          // ),
          // FlareActor(
          //   'assets/background.flr',
          //   alignment: Alignment.center,
          //   fit: BoxFit.cover,
          //   // animation: 'monday',

          //   // animation: firebaseNotifier.favoriteState == FavoriteState.fav
          //   // ? 'favorite'
          //   // : 'unfavorite'
          // ),
          // Image.asset(
          //   'assets/Slice1.png',
          //   alignment: Alignment.center,
          //   fit: BoxFit.cover,
          // ),
          FlareActor(
            'assets/test_rive.flr',
            alignment: Alignment.center,
            fit: BoxFit.cover,

            animation: 'monday',

            // animation: firebaseNotifier.favoriteState == FavoriteState.fav
            // ? 'favorite'
            // : 'unfavorite'
          ),
          ClockDig(),

          // RotateCircle(),

          // Align(
          //     alignment: Alignment.center,
          //     child: Transform(
          //         transform: Matrix4.identity()
          //           ..setEntry(3, 2, 0.001)
          //           // ..rotateZ(animation['rotate']),
          //           // ..rotateX(animation['rotate'])
          //           ..rotateY(0.0),
          //         // ..rotateZ(0.3),
          //         child: AnimatedBuilder(
          //           builder: (BuildContext context, Widget child) {
          //             return Container(
          //               child: CustomPaint(
          //                 painter: MyClockPainter(
          //                     // ..color = ;
          //                     radiusInOut: radiusInOut.value,
          //                     sizeInc: sizeInc.value,
          //                     secColor: Colors.orangeAccent.shade400,
          //                     primColor: Colors.lightBlueAccent.shade100,
          //                     whiteColor: Colors.white),
          //               ),
          //             );
          //           },
          //           animation: cont2,
          //         ))),
        ],
      ),
    );
  }
}

class DotRoatatePaint extends CustomPainter {
  DotRoatatePaint({this.index});

  final index;

  @override
  void paint(Canvas canvas, Size size) {
    // print('$index');
    final rectCirclePaint = Paint()
      ..filterQuality = FilterQuality.high
      ..isAntiAlias = true
      // ..color = Colors.lightBlueAccent.shade100
      // ..color = Color(0xFF5FFAE0)
      // ..color = Color(0xFFC22ED0)
      // ..color = Color(0xFF5FFAE0)
      ..color = Color(0xFFFE1C2D)

      // ..color = Color(0xFFEF96C5)
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

    // print('x: ${size.width}, y: ${size.height}');
    // final center = Offset(size.width * 0.001, 0);
    final center = Offset(size.width / 2, size.height / 2);
    // canvas.translate(size.width / 2 + 10, size.height / 2 - 10);
    // canvas.save();
    // for (int i = 0; i < 12; i++) {
    //   canvas.drawCircle(Offset(size.width * 0.13, 0), 2.0, whiteDotPaint);
    //   canvas.rotate(2 * pi / 12);
    // }

    // canvas.drawCircle(Offset(x, y), 83, rectCirclePaint);

    // for (var i = 0; i < 16; i++) {
    //   canvas.drawArc(
    //       Rect.fromCircle(center: center, radius: 83),
    //       i * pi / 8,
    //       pi / 10,
    //       false,
    //       i >= 6 && i <= 8 ? rectCirclePaint1 : rectCirclePaint);
    // }

    // canvas.drawRect(
    //     Rect.fromCenter(center: center, width: 200, height: 80), rectp);
    canvas.drawCircle(center, 40, circlep);
    canvas.drawCircle(center, 36, circlep1);

    canvas.rotate(-pi / 2);
    canvas.save();
    for (var i = 0; i < 60; i++) {
      // if (i != index) {mm xkklcn vnmlnjkmjnkkndjkk
      canvas.drawArc(Rect.fromCircle(center: center, radius: 46), i * pi / 30,
          pi / 30, false, i == index ? rectCirclePaint : rectCirclePaint1);
      // }
    }

    canvas.rotate(-pi / 60);
    // canvas.save();

    for (int i = 0; i < 12; i++) {
      canvas.drawCircle(
          Offset(36, 0), 2, DateTime.now().hour == i ? rectp1 : rectp);
      canvas.rotate(2 * pi / 12);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MyClockPainter extends CustomPainter {
  MyClockPainter(
      {this.primColor,
      this.secColor,
      this.whiteColor,
      this.radiusInOut,
      this.sizeInc});
  final primColor;
  final secColor;
  final whiteColor;
  final radiusInOut;
  final sizeInc;

  List<Offset> drawPoly(
      var size, Canvas canvas, Paint paint, double lengthOfSide) {
    List<Offset> verts = [];
    final path = Path();
    path.moveTo(size.dx + lengthOfSide, size.dy);
    for (var i = 0; i < 6; i++) {
      if (Random().nextInt(5) != null) {}
      verts.add(size +
          Offset(lengthOfSide * cos(i * 60 * pi / 180),
              lengthOfSide * sin(i * 60 * pi / 180)));

      path.lineTo(verts[i].dx, verts[i].dy);

      // if (i == 5) canvas.drawShadow(path, Colors.lightBlueAccent, 1, false);
    }
    path.close();

    canvas.drawPath(path, paint);

    return verts;
  }

  void drawPolyRowCol(Offset o, Canvas c, Paint pDefault, double sideLength) {
    // drawPoly(o, c, pDefault, sideLength);

    for (var i = -4; i < 50; i++) {
      for (var j = -5; j < 20; j++) {
        if (i % 2 == 0) {
          drawPoly(Offset(i * 18.0 - 10, j * 20.0), c, pDefault, sideLength);
        } else {
          drawPoly(
              Offset(i * 18.0 - 10, j * 20.0 - 10), c, pDefault, sideLength);
        }
      }
    }
  }

  void drawArcCustom(Canvas c, Paint p, Offset s, double radius,
      double startAngle, double sweepAngle) {
    c.drawArc(Rect.fromCircle(center: s, radius: radius), startAngle,
        sweepAngle, false, p);
  }

  void drawpurpleBars(
      Canvas c, Paint pThickPaint, Paint pThinPaint, Offset s, double radius) {
    drawArcCustom(c, pThinPaint, s, radius, 2.8, -pi / 5);
    drawArcCustom(c, pThinPaint, s, radius, 3.4, pi / 5);
    drawArcCustom(c, pThinPaint, s, radius, -0.33, -pi / 5);
    drawArcCustom(c, pThinPaint, s, radius, 0.25, pi / 5);
    drawArcCustom(c, pThickPaint, s, radius, 0.25, -pi / 5.5);
    drawArcCustom(c, pThickPaint, s, radius, 2.8, pi / 5.5);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // print('$size');
    final angle = radians(360 / 60) - math.pi / 2.0;
    // final center = (Offset.zero & size).center;

    final whiteDotPaint1 = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 3.0)
      ..isAntiAlias = true
      ..strokeWidth = 6
      // ..color = Colors.lightBlueAccent.shade100
      ..color = Color(0xFFFE1C2D)
      // ..color = Color(0xFFCCFBFF)
      ..filterQuality = FilterQuality.high;
    final whiteDotPaint2 = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 3.0)
      ..isAntiAlias = true
      ..strokeWidth = 0.5
      // ..color = Colors.lightBlueAccent.shade100
      // ..color = Color(0xFF5FFAE0)
      // ..color = Color(0xFFCCFBFF)
      ..color = Color(0xFFC22ED0)
      ..filterQuality = FilterQuality.high;

    final whiteDotPaint3 = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 2.0)
      ..isAntiAlias = true
      ..strokeWidth = 0.2
      // ..color = Colors.lightBlueAccent.shade100
      // ..color = Color(0xFF5FFAE0)
      ..color = Color(0xFFCCFBFF)
      ..filterQuality = FilterQuality.high;

    final longCirclePaint = Paint()
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..filterQuality = FilterQuality.high
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 1)
      ..color = secColor;

    final redDashPaint = Paint()
      ..strokeWidth = 2
      ..filterQuality = FilterQuality.high
      ..color = primColor;

    final redCurvePaint = Paint()
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..filterQuality = FilterQuality.high
      ..color = Color(0xFFCCFBFF);

    final redLongThickCurvePaint = Paint()
      ..isAntiAlias = true
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 1.0)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..filterQuality = FilterQuality.high
      // ..color = Color(0xFFCCFBFF);
      ..color = Color(0xFFC22ED0);

    final purpleCirclePaint = Paint()
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..filterQuality = FilterQuality.high
      ..color = primColor;

    final smallWhiteCirclePaint = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 1.0)
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..filterQuality = FilterQuality.high
      // ..maskFilter = MaskFilter.blur(BlurStyle.solid, 1)
      ..color = Colors.white;

    final longWhiteCirclePaint = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 3.0)
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..filterQuality = FilterQuality.high
      // ..maskFilter = MaskFilter.blur(BlurStyle.solid, 1)
      ..color = Colors.white;

    final smallRedCirclePaint = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 2.0)
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..filterQuality = FilterQuality.high
      ..color = Color(0xFFFE1C2D);
    // Color(0xFFC22ED0)
    // ..color = Color(0xFFCCFBFF);

    final smallRedCirclePaint1 = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 5.0)
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..filterQuality = FilterQuality.high
      ..color = Colors.white;
    // ..color = Color(0xFFC22ED0).withOpacity(0.5);
    // Color(0xFFC22ED0)
    // ..color = Color(0xFFCCFBFF);

    final smallCirclePaint = Paint()
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..filterQuality = FilterQuality.high
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 1)
      ..color = whiteColor;

    final paintBlack = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 1)
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high
      ..color = Colors.black87;

    final rectCirclePaint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 3.0);

    final rectCirclePaint1 = Paint()
      ..color = Color(0xFFC22ED0)
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 3.0);

// final paintTest = p

    final center = Offset(size.width / 2, size.height / 2);
    // print('x1: ${size.width}, y: ${size.height}');

    // drawPolyRowCol(Offset(size.width, size.height), canvas, paintBlack, 10);

    // drawpurpleBars(
    // canvas, redLongThickCurvePaint, redCurvePaint, center, 165.0);

    // canvas.drawCircle(center, 125.0, longCirclePaint);

    canvas.drawCircle(center, 95.0, longWhiteCirclePaint);

    canvas.drawCircle(center, 75.0, smallWhiteCirclePaint);
    canvas.drawCircle(center, 72.0, smallRedCirclePaint);

    canvas.drawCircle(center, 69.0, smallWhiteCirclePaint);

    // for (var i = 0; i < 16; i++) {
    //   canvas.drawArc(Rect.fromCircle(center: center, radius: 93), i * pi / 8,
    //       pi / 10, false, i > 5 && i < 9 ? rectCirclePaint : rectCirclePaint1);
    // }

    // for (int i = 0; i < 8; i++) {
    //   canvas.drawCircle(Offset(size.width * 0.19, 0), 5.0, whiteDotPaint);
    //   canvas.rotate(2 * pi / 8);
    // }

    canvas.translate(size.width / 2, size.height / 2);
    canvas.save();

    for (int i = 0; i < 4; i++) {
      canvas.drawCircle(Offset(95, 0), 4, whiteDotPaint1);
      canvas.rotate(2 * pi / 4);
    }

    // for (int i = 0; i < 60; i++) {
    //   canvas.drawCircle(Offset(radiusInOut, 0), sizeInc - 0.5, whiteDotPaint2);
    //   canvas.rotate(2 * pi / 60);
    // }

    // for (int i = 0; i < 60; i++) {
    //   canvas.drawCircle(
    //       Offset(radiusInOut + 6.0, 0), sizeInc - 1.0, whiteDotPaint3);
    //   canvas.rotate(2 * pi / 60);
    // }
    // for (int i = 0; i < 24; i++) {
    //   canvas.drawLine(Offset(size.width * 0.13, 0),
    //       Offset(size.width * 0.13, 13), redDashPaint);
    //   canvas.rotate(2 * pi / 24);
    // }

    // for (int i = 0; i < 12; i++) {
    //   canvas.drawCircle(Offset(size.width * 0.14, 0), 2.0, whiteDotPaint);
    //   canvas.rotate(2 * pi / 12);
    // }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class RotateCircle extends StatefulWidget {
  @override
  _RotateCircleState createState() => _RotateCircleState();
}

class _RotateCircleState extends State<RotateCircle> {
  // var timer;
  int index;
  @override
  void initState() {
    index = 0;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        if (index == 59)
          index = 0;
        else
          index++;
      });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(left: 200.0, bottom: 10),
          child: Container(
              child: CustomPaint(painter: DotRoatatePaint(index: index))),
        ));
  }
}

class ClockDig extends StatefulWidget {
  @override
  _ClockDigState createState() => _ClockDigState();
}

class _ClockDigState extends State<ClockDig> {
  var _now = DateTime.now();
  Timer _timer;
  int index = 0;
  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );

      if (index == 59)
        index = 0;
      else
        index++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 100,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Text('${_now.getDayName()}',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white))),
                    ),
                    GradientText(
                      '${_now.getTwelveHourFormat().addZero()}   ${_now.minute.addZero()}',
                      gradient: LinearGradient(colors: [
                        Color(0xFF5FFAE0),
                        Color(0xFFC22ED0),
                      ]),
                      style: TextStyle(fontSize: 56),
                    ),
                    Padding(
                      child: GradientText(
                        ':',
                        gradient: LinearGradient(colors: [
                          Color(0xFF5FFAE0),
                          Color(0xFFC22ED0),
                        ]),
                        style: TextStyle(fontSize: 62),
                      ),
                      padding: EdgeInsets.only(bottom: 12),
                    ),
                  ],
                ) // alignment: Alignment.center,
                    ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                        child: CustomPaint(
                            painter: DotRoatatePaint(index: _now.second))),
                    GradientText('${(_now.second + 1).addZero()}',
                        gradient: LinearGradient(colors: [
                          Color(0xFF5FFAE0),
                          Color(0xFFC22ED0),
                        ]),
                        style: TextStyle(fontSize: 32),
                        textAlign: TextAlign.center),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 22.0, left: 5),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('${_now.amOrPm()}',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white))),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimeText extends StatelessWidget {
  const TimeText({
    Key key,
    @required String text,
  })  : _text = text,
        super(key: key);

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 200,
          height: 100,
          child: GradientText(_text,
              gradient: LinearGradient(colors: [
                Color(0xFF5FFAE0),
                Color(0xFFC22ED0),
              ]),
              style: TextStyle(fontSize: 62),
              textAlign: TextAlign.center)),
    );
  }
}

extension stickWithZero on int {
  String addZero() {
    if (this >= 0 && this <= 9)
      return '0$this';
    else
      return '$this';
  }
}

extension nameOfDay on DateTime {
  int getTwelveHourFormat() {
    if (this.hour != null && this.hour > 12)
      return (this.hour - 12);
    else
      return this.hour;
  }

  String amOrPm() {
    // if (this.hour == 0) return 'AM';
    if (this.hour > 12 && this.hour != null)
      return 'PM';
    else
      return 'AM';
  }

  String getDayName() {
    switch (this?.weekday) {
      case 1:
        {
          return 'MONDAY';
        }
        break;
      case 2:
        {
          return 'TUESDAY';
        }
        break;
      case 3:
        {
          return 'WEDNESDAY';
        }
        break;
      case 4:
        {
          return 'THURSDAY';
        }
        break;
      case 5:
        {
          return 'FRIDAY';
        }
        break;
      case 6:
        {
          return 'SATURDAY';
        }
        break;
      case 7:
        {
          return 'SUNDAY';
        }
        break;

      default:
        {
          return 'TODAY';
        }
        break;
    }
  }
}
