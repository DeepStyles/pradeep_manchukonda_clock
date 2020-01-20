import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_clock_helper/model.dart';
import 'package:pradeep_manchukonda_clock/providers/day_notify.dart';

import 'package:pradeep_manchukonda_clock/seconds_widget.dart';
import 'package:pradeep_manchukonda_clock/utils.dart';
import 'package:pradeep_manchukonda_clock/constants.dart';
import 'package:pradeep_manchukonda_clock/seconds_circle_paint.dart';
import 'package:pradeep_manchukonda_clock/grad_text.dart';
import 'package:pradeep_manchukonda_clock/reusable_text.dart';
import 'package:provider/provider.dart';

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
    final dayNameNotifier =
        Provider.of<DayNameNotifier>(context, listen: false);
    setState(() {
      _now = DateTime.now();
      if (_now.hour == 0 && _now.minute == 0 && _now.second == 0)
        dayNameNotifier.reload('${getTime('EEEE')}');

      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ///temp variables to display time, dayName.
    final aspect = MediaQuery.of(context).size.aspectRatio;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final hour = widget.clockModel.is24HourFormat
        ? getTime('${Constants.str24HourFormat}')
        : getTime('${Constants.str12HourFormat}');
    final minute = getTime('${Constants.strMins}');
    final amOrpm = getTime('${Constants.stramOrpm}');
    final dayName = getTime('${Constants.strDayName}');

    return Semantics(
      enabled: true,
      label: Constants.semanticClockTime,
      readOnly: true,
      value:
          'Its ${getTime(Constants.str12HourFormat)} hour ${getTime(Constants.strMins)} minutes ${getTime(Constants.stramOrpm)}',
      child: Stack(
        alignment: Constants.cAlign,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: width * 0.12),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: width ?? 0 * 0.25,
                maxHeight: height ?? 0 * 0.15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  NeumophicWidget(
                      width: width,
                      height: height,
                      text: hour,
                      primColor: widget.gradTopColor,
                      aspect: aspect),
                  SizedBox(
                    width: width * 0.05,
                    height: height * 0.12,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: ReusableText(
                        fontSize: aspect * 25,
                        botPadding: 5,
                        textName: ':',
                      ),
                    ),
                  ),
                  NeumophicWidget(
                      width: width,
                      height: height,
                      text: minute,
                      primColor: widget.gradTopColor,
                      aspect: aspect),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   width: width * 0.1,
          // ),
          Container(
            padding: EdgeInsets.only(left: width * 0.31),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ///accessability feature to get DayName

                ///this paints the circles, next to time

                Container(
                    child: CustomPaint(
                        painter: DigiTalClockPaint(
                            primColor: widget.gradBottomColor,
                            secColor: widget.gradTopColor,
                            second: _now.second,
                            secondsCirRad: aspect * 23.0,
                            midCirRad: aspect * 19.0,
                            dotCirRad: aspect * 16.0))),

                ///This widget used to animate the seconds text inside the circles painted
                Semantics(
                  enabled: true,
                  label: Constants.semanticDayName,
                  readOnly: true,
                  value: 'Its ${getTime('EEEE')}',
                  child: ReusableText(
                    textName: dayName.toUpperCase(),
                    alignment: Alignment.center,
                    fontSize: aspect * 4,
                    botPadding: aspect * 15,
                  ),
                ),
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
                    tween:
                        Tween<double>(begin: aspect * 15.0, end: aspect * 20.0),
                    builder: (_, padding, __) {
                      return ReusableText(
                          textName: amOrpm,
                          alignment: Constants.cAlign,
                          fontSize: aspect * 4,
                          leftPadding: 2,
                          topPadding: padding);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// class TextBeside extends StatelessWidget {
//   const TextBeside({
//     Key key,
//     @required this.widthFac,
//     @required this.fontSize,
//     @required this.text,
//     @required this.aspect,
//     @required this.width,
//     @required this.height,
//   }) : super(key: key);

//   final double widthFac;
//   final double fontSize;
//   final String text;
//   final double aspect;
//   final double width;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // flex: 1,
//       constraints:
//           BoxConstraints.expand(width: width * 0.04, height: height * 0.05),

//       child: FittedBox(
//         fit: BoxFit.contain,
//         child: ReusableText(
//           textName: text,
//           fontSize: fontSize,
//         ),
//       ),
//     );
//   }
// }

class NeumophicWidget extends StatelessWidget {
  const NeumophicWidget({
    Key key,
    @required this.text,
    @required this.primColor,
    @required this.aspect,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final String text;
  final Color primColor;
  final double aspect;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    // print('nuemorphic build...');
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: ReusableText(
          textName: '$text',
        ),
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                color: Colors.white,
                offset: Offset(1, 0.5),
                spreadRadius: 0.5),
            BoxShadow(
                blurRadius: 1,
                color: primColor,
                offset: Offset(0.5, 1),
                spreadRadius: 0.1)
          ],
          color: Color(0xFF060D29),
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle),
      constraints:
          BoxConstraints.expand(width: width * 0.08, height: height * 0.12),
    );
  }
}
