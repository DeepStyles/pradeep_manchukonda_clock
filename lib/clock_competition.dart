import 'dart:async';
import 'dart:core';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:pradeep_manchukonda_clock/color_constants.dart';
import 'package:pradeep_manchukonda_clock/digi_clock_paint.dart';
import 'package:pradeep_manchukonda_clock/extensions.dart';

class DigitalClock extends StatelessWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FlareActor(
          'assets/test_rive.flr',
          alignment: Alignment.center,
          fit: BoxFit.cover,
          animation: 'tuesday',
        ),
        TweenAnimationBuilder(
          curve: Curves.bounceOut,
          tween: Tween<double>(begin: 0.0, end: 0.95),
          builder: (_, double scaleValue, __) {
            return Transform.scale(child: ClockDig(), scale: scaleValue);
          },
          duration: const Duration(seconds: 3),
        ),
      ],
    );
  }
}

class ClockDig extends StatefulWidget {
  @override
  _ClockDigState createState() => _ClockDigState();
}

class _ClockDigState extends State<ClockDig> {
  DateTime _now;
  Timer _timer;
  int _index;

  @override
  void initState() {
    _index = 0;
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

      if (_index == 59)
        _index = 0;
      else
        _index++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.38,
        height: 100,
        // color: Colors.yellowAccent,
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
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Text('${_now.getDayName()}',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.white))),
                    ),
                    GradientText(
                        '${_now.getTwelveHourFormat().addZero()}  ${_now.minute.addZero()}',
                        gradient: LinearGradient(colors: [
                          ColorConstants.colorMap['tuesday-top'],
                          ColorConstants.colorMap['tuesday-bottom'],
                        ]),
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.085)),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: GradientText(
                        ':',
                        gradient: LinearGradient(colors: [
                          Color(0xFF5FFAE0),
                          Color(0xFFC22ED0),
                        ]),
                        style: TextStyle(fontSize: 42),
                      ),
                    ),
                  ],
                ) // alignment: Alignment.center,
                    ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                        child: CustomPaint(
                            painter: DigiTalClockPaint(index: _now.second))),
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
