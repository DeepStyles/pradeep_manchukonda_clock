import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

import 'package:pradeep_manchukonda_clock/seconds_widget.dart';
import 'package:pradeep_manchukonda_clock/utils.dart';
import 'package:pradeep_manchukonda_clock/constants.dart';
import 'package:pradeep_manchukonda_clock/seconds_circle_paint.dart';
import 'package:pradeep_manchukonda_clock/grad_text.dart';
import 'package:pradeep_manchukonda_clock/reusable_text.dart';

class DigClock extends StatefulWidget {
  DigClock({this.gradTopColor, this.gradBottomColor, this.clockModel});
  final ClockModel clockModel;
  final gradTopColor;
  final gradBottomColor;

  @override
  _DigClockState createState() => _DigClockState();
}

class _DigClockState extends State<DigClock> {
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
    ///temp variables to display time, dayName,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                      fit: FlexFit.loose,
                      flex: 2,
                      child: Stack(
                        alignment: Constants.cAlign,
                        children: <Widget>[
                          ///ACCESS FEATURE to get Time
                          Semantics(
                              enabled: true,
                              label: Constants.semanticClockTime,
                              readOnly: true,
                              value:
                                  'Its ${getTime(Constants.str12HourFormat)} hour ${getTime(Constants.strMins)} minutes ${getTime(Constants.stramOrpm)}',
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: aspect * 4,
                                  ),
                                  GradTextWidget(
                                    text: '$hour ',
                                    gradTopColor: widget.gradTopColor,
                                    gradBottomColor: widget.gradBottomColor,
                                    textFont: aspect * 30,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      bottom: aspect * 3.0,
                                    ),
                                    child: GradTextWidget(
                                      text: ':',
                                      gradTopColor: widget.gradTopColor,
                                      gradBottomColor: widget.gradBottomColor,
                                      textFont: aspect * 24,
                                    ),
                                  ),
                                  GradTextWidget(
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
                        ///accessability feature to get DayName
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
                          ),
                        ),
                        Container(
                            child:

                                ///this paints the circles, next to time
                                CustomPaint(
                                    painter: DigiTalClockPaint(
                                        primColor: widget.gradBottomColor,
                                        secColor: widget.gradTopColor,
                                        second: _now.second,
                                        secondsCirRad: aspect * 23.0,
                                        midCirRad: aspect * 19.0,
                                        dotCirRad: aspect * 16.0))),

                        ///This widget used to animate the seconds text inside the circles painted
                        SecondsAnimatedWidget(
                            second: _now.second,
                            topColor: widget.gradTopColor,
                            botColor: widget.gradBottomColor,
                            aspect: aspect),

                        ///This only appears when option of 24 hrs format changes in settings icon
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
