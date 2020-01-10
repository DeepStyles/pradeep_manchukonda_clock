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
          animation: 'wednesday',
        ),
        TweenAnimationBuilder(
          curve: Curves.bounceOut,
          tween: Tween<double>(begin: 0.0, end: 1),
          builder: (_, scaleValue, __) {
            return Transform.scale(
                child: ClockDig(
                  gradTopColor: ColorConstants.colorMap['wednesday-top'],
                  gradBottomColor: ColorConstants.colorMap['wednesday-bottom'],
                ),
                scale: scaleValue);
          },
          duration: const Duration(seconds: 3),
        ),
      ],
    );
  }
}

class ClockDig extends StatefulWidget {
  ClockDig({this.gradTopColor, this.gradBottomColor});

  final gradTopColor;
  final gradBottomColor;

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
    // print('width: ${MediaQuery.of(context).size.width}');
    // print('height: ${MediaQuery.of(context).size.height}');
    // print('aspect: ${MediaQuery.of(context).size.aspectRatio}');
    final aspect = MediaQuery.of(context).size.aspectRatio;
    return Center(
      child: Container(
        width: aspect * 140,
        height: aspect * 48,
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
                    Semantics(
                      label: 'Whats Today??',
                      readOnly: true,
                      value: 'Its ${_now.getDayName()}',
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                        ),
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: Text('${_now.getDayName()}',
                                style: TextStyle(
                                    fontSize: aspect * 5,
                                    color: Colors.white))),
                      ),
                    ),
                    Semantics(
                        label: 'Clock Time',
                        readOnly: true,
                        value:
                            '${_now.getTwelveHourFormat()} ${_now.minute} ${_now.amOrPm()}',
                        child: GradTextWidget(
                          text:
                              '${_now.getTwelveHourFormat().addZero()}  ${_now.minute.addZero()}',
                          gradTopColor: widget.gradTopColor,
                          gradBottomColor: widget.gradBottomColor,
                          textFont: aspect * 30,
                        )),
                    Padding(
                      padding: EdgeInsets.only(bottom: aspect * 4.0),
                      child: GradientText(
                        ':',
                        gradient: LinearGradient(colors: [
                          widget.gradTopColor,
                          widget.gradBottomColor,
                        ]),
                        style: TextStyle(fontSize: aspect * 25),
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
                            painter: DigiTalClockPaint(
                                primColor: widget.gradTopColor,
                                secColor: widget.gradBottomColor,
                                index: _now.second,
                                secondsCirRad: aspect * 22.0,
                                midCirRad: aspect * 19.0,
                                dotCirRad: aspect * 15.0))),
                    GradTextWidget(
                      text: '${(_now.second + 1).addZero()}',
                      gradTopColor: widget.gradTopColor,
                      gradBottomColor: widget.gradBottomColor,
                      textFont: aspect * 13,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: aspect * 12.0, left: 5),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('${_now.amOrPm()}',
                              style: TextStyle(
                                  fontSize: aspect * 4, color: Colors.white))),
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

class GradTextWidget extends StatelessWidget {
  const GradTextWidget({
    Key key,
    @required Color gradBottomColor,
    @required Color gradTopColor,
    @required double textFont,
    @required String text,
  })  : _text = text,
        _textFont = textFont,
        _gradTopColor = gradTopColor,
        _gradBottomColor = gradBottomColor,
        super(key: key);

  final String _text;
  final double _textFont;
  final Color _gradTopColor;
  final Color _gradBottomColor;

  @override
  Widget build(BuildContext context) {
    return GradientText(_text,
        gradient: LinearGradient(colors: [_gradTopColor, _gradBottomColor]),
        style: TextStyle(fontSize: _textFont),
        textAlign: TextAlign.center);
  }
}
