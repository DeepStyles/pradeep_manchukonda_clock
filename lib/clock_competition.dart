import 'dart:async';
import 'dart:core';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

import 'package:pradeep_manchukonda_clock/utils.dart';
import 'package:pradeep_manchukonda_clock/constants.dart';
import 'package:pradeep_manchukonda_clock/digi_clock_paint.dart';

import 'package:pradeep_manchukonda_clock/grad_text.dart';
import 'package:pradeep_manchukonda_clock/reusable_text.dart';

class DigitalClock extends StatelessWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FlareActor(
          Constants.assetPath,
          alignment: Constants.cAlign,
          fit: BoxFit.cover,
          animation: '${getTime('EEEE').toLowerCase()}',
        ),
        TweenAnimationBuilder(
          curve: Constants.curveBounce,
          tween: Tween<double>(begin: 0, end: 1),
          builder: (_, scaleValue, __) {
            return Transform.scale(
                child: ClockDig(
                  clockModel: model,
                  gradTopColor:
                      Constants.colorMap['${getTime('EEEE').toLowerCase()}Top'],
                  gradBottomColor: Constants
                      .colorMap['${getTime('EEEE').toLowerCase()}Bottom'],
                ),
                scale: scaleValue);
          },
          duration: Constants.scaleDur,
        ),
      ],
    );
  }
}

class ClockDig extends StatefulWidget {
  ClockDig({this.gradTopColor, this.gradBottomColor, this.clockModel});
  final ClockModel clockModel;
  final gradTopColor;
  final gradBottomColor;

  @override
  _ClockDigState createState() => _ClockDigState();
}

class _ClockDigState extends State<ClockDig> {
  DateTime _now;
  Timer _timer;
  @override
  void initState() {
    super.initState();
    widget.clockModel.addListener(_updateModel);
    _updateTime();
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.clockModel.removeListener(_updateModel);
    widget.clockModel.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {});
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final aspect = MediaQuery.of(context).size.aspectRatio;
    final hour =
        widget.clockModel.is24HourFormat ? getTime('HH') : getTime('hh');
    final minute = getTime('mm');
    final amOrpm = getTime('a');
    final dayName = getTime('EEEE');

    return Center(
      child: Container(
        width: aspect * 140,
        height: aspect * 47,
        child: Stack(
          alignment: Constants.cAlign,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                    child: Stack(
                  alignment: Constants.cAlign,
                  children: <Widget>[
                    Semantics(
                      label: Constants.semanticDayName,
                      readOnly: true,
                      value: 'Its ${getTime('EEEE')}',
                      child: ReusableText(
                        textName: dayName,
                        alignment: Constants.tcAlign,
                        fontSize: aspect * 5,
                        topPadding: aspect * 4,
                        leftPadding: 2,
                      ),
                    ),
                    Semantics(
                        label: Constants.semanticClockTime,
                        readOnly: true,
                        value:
                            'Its ${getTime('hh')} hour ${getTime('mm')} minutes ${getTime('a')}',
                        child: GradTextWidget(
                          text: '$hour  $minute',
                          gradTopColor: widget.gradTopColor,
                          gradBottomColor: widget.gradBottomColor,
                          textFont: aspect * 30,
                        )),
                    Padding(
                      padding: EdgeInsets.only(bottom: aspect * 4.0),
                      child: GradTextWidget(
                        text: ':',
                        gradTopColor: widget.gradTopColor,
                        gradBottomColor: widget.gradBottomColor,
                        textFont: aspect * 25,
                      ),
                    ),
                  ],
                )),
                Stack(
                  alignment: Constants.cAlign,
                  children: <Widget>[
                    Container(
                        child: CustomPaint(
                            painter: DigiTalClockPaint(
                                primColor: widget.gradBottomColor,
                                secColor: widget.gradTopColor,
                                second: _now.second,
                                secondsCirRad: aspect * 22.0,
                                midCirRad: aspect * 18.0,
                                dotCirRad: aspect * 15.0))),
                    GradTextWidget(
                      text: addZero(DateTime.now().second),
                      gradTopColor: widget.gradTopColor,
                      gradBottomColor: widget.gradBottomColor,
                      textFont: aspect * 13,
                    ),
                    ReusableText(
                        textName: amOrpm,
                        alignment: Constants.bcAlign,
                        fontSize: aspect * 4,
                        // topPadding: 0,
                        leftPadding: 3,
                        botPadding: aspect * 12.0),
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
