import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:simple_animations/simple_animations.dart';

import 'package:pradeep_manchukonda_clock/utils.dart';
import 'package:pradeep_manchukonda_clock/constants.dart';
import 'package:pradeep_manchukonda_clock/seconds_circle_paint.dart';
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
    final hour = widget.clockModel.is24HourFormat
        ? getTime('${Constants.str24HourFormat}')
        : getTime('${Constants.str12HourFormat}');
    final minute = getTime('${Constants.strMins}');
    final amOrpm = getTime('${Constants.stramOrpm}');
    final dayName = getTime('${Constants.strDayName}');

    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: aspect * 35.0),
        child: SizedBox(
          width: aspect * 135,
          height: aspect * 47,
          child: Stack(
            alignment: Constants.cAlign,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Flexible(
                      flex: 2,
                      child: Stack(
                        alignment: Constants.cAlign,
                        children: <Widget>[
                          Semantics(
                              enabled: true,
                              label: Constants.semanticClockTime,
                              readOnly: true,
                              value:
                                  'Its ${getTime('hh')} hour ${getTime('mm')} minutes ${getTime('a')}',
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: aspect * 4,
                                  ),
                                  GradTextWidget(
                                    // width: aspect * 80.0,
                                    // height: aspect * 45,
                                    // fontFamily: 'Rajdhani-Light',

                                    text: '$hour ',
                                    gradTopColor: widget.gradTopColor,
                                    gradBottomColor: widget.gradBottomColor,
                                    textFont: aspect * 30,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      // right: aspect * 45.0,
                                      bottom: aspect * 3.0,
                                    ),
                                    child: GradTextWidget(
                                      // fontFamily: 'Rajdhani-Light',

                                      // width: aspect * 5,
                                      // height: aspect * 35,
                                      text: ':',
                                      gradTopColor: widget.gradTopColor,
                                      gradBottomColor: widget.gradBottomColor,
                                      textFont: aspect * 24,
                                    ),
                                  ),
                                  GradTextWidget(
                                    // fontFamily: 'Rajdhani-Light',
                                    text: ' $minute',
                                    gradTopColor: widget.gradTopColor,
                                    gradBottomColor: widget.gradBottomColor,
                                    textFont: aspect * 30,
                                  ),
                                ],
                              )),
                        ],
                      )),
                  Flexible(
                    flex: 1,
                    child: Stack(
                      alignment: Constants.cAlign,
                      children: <Widget>[
                        Semantics(
                          enabled: true,
                          label: Constants.semanticDayName,
                          readOnly: true,
                          value: 'Its ${getTime('EEEE')}',
                          child: ReusableText(
                            textName: dayName.toUpperCase(),
                            alignment: Alignment.center,
                            fontSize: aspect * 4.5,
                            botPadding: aspect * 15,
                            // rightPadding: 6,
                          ),
                        ),
                        Container(
                            child: CustomPaint(
                                painter: DigiTalClockPaint(
                                    primColor: widget.gradBottomColor,
                                    secColor: widget.gradTopColor,
                                    second: _now.second,
                                    secondsCirRad: aspect * 23.0,
                                    midCirRad: aspect * 19.0,
                                    dotCirRad: aspect * 16.0))),
                        SecondsAnimatedWidget(
                            second: _now.second,
                            widget: widget,
                            aspect: aspect),
                        AnimatedOpacity(
                          duration: Constants.durThree,
                          opacity: widget.clockModel.is24HourFormat ? 0 : 1,
                          child: TweenAnimationBuilder(
                            duration: Constants.durThree,
                            tween: Tween<double>(
                                begin: aspect * 8.0, end: aspect * 13.0),
                            builder: (_, padding, __) {
                              return ReusableText(
                                  textName: amOrpm,
                                  alignment: Constants.bcAlign,
                                  fontSize: aspect * 4,
                                  leftPadding: 2,
                                  botPadding: padding);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondsAnimatedWidget extends StatelessWidget {
  SecondsAnimatedWidget({
    Key key,
    @required int second,
    @required this.widget,
    @required this.aspect,
  })  : _second = second,
        super(key: key);

  final int _second;
  final ClockDig widget;
  final double aspect;

  final tween = MultiTrackTween([
    Track("opacity")
        .add(Duration(milliseconds: 700), Tween<double>(begin: 0, end: 1.0)),
    Track("translate").add(Duration(milliseconds: 700),
        Tween(begin: Offset(0, -0.5), end: Offset(0, 0))),
  ]);

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
        duration: tween.duration,
        tween: tween,
        curve: Curves.easeOutSine,
        playback: Playback.START_OVER_FORWARD,
        builder: (_, anim) {
          return Opacity(
            child: FractionalTranslation(
              translation: anim['translate'],
              child: GradTextWidget(
                text: addZero(_second == 0 ? 60 : _second),
                gradTopColor: widget.gradTopColor,
                gradBottomColor: widget.gradBottomColor,
                textFont: aspect * 12,
              ),
            ),
            opacity: anim['opacity'],
          );
        });
  }
}
