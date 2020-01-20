import 'package:flutter/material.dart';
import 'package:pradeep_manchukonda_clock/providers/time_notify.dart';

import 'package:simple_animations/simple_animations.dart';

import 'package:pradeep_manchukonda_clock/utilities/common_funcs.dart';

import 'package:pradeep_manchukonda_clock/constants.dart';
import 'package:pradeep_manchukonda_clock/seconds_circle_paint.dart';
import 'package:pradeep_manchukonda_clock/reusable_text.dart';
import 'package:pradeep_manchukonda_clock/seconds_widget.dart';
import 'package:provider/provider.dart';

class DigClock extends StatelessWidget {
  const DigClock({this.gradTopColor, this.gradBottomColor});
  // final ClockModel clockModel;
  final gradTopColor;
  final gradBottomColor;

  @override
  Widget build(BuildContext context) {
    final timeNotifier = Provider.of<TimeNotifier>(context, listen: false);
    final media = MediaQuery.of(context);

    final safeAreaHor = media.padding.left + media.padding.right;
    final safeAreaVer = media.padding.top + media.padding.bottom;
    final aspect = media.size.aspectRatio;
    final width = media.size.width - safeAreaHor;
    final height = media.size.height - safeAreaVer;
    print('dig clock build...');
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
              padding: EdgeInsets.only(top: height * 0.07),
              child: Container(
                alignment: Alignment.center,
                // color: Colors.blueGrey,
                width: width * 0.25,
                height: height * 0.13,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Selector<TimeNotifier, String>(
                      shouldRebuild: (previous, next) => previous != next,
                      selector: (_, timeNotifier) => timeNotifier.hour,
                      builder: (_, hour, __) {
                        return NeumophicWidget(
                            width: width,
                            height: height,
                            text: hour,
                            secColor: gradBottomColor,
                            primColor: gradTopColor,
                            aspect: aspect);
                      },
                    ),
                    SizedBox(
                      width: width * 0.05,
                      height: height * 0.8,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: ReusableText(
                          fontSize: aspect * 25,
                          botPadding: 5,
                          textName: ':',
                        ),
                      ),
                    ),
                    Selector<TimeNotifier, String>(
                      shouldRebuild: (previous, next) => previous != next,
                      selector: (_, timeNotifier) => timeNotifier.minute,
                      builder: (_, minute, __) {
                        return NeumophicWidget(
                            width: width,
                            height: height,
                            text: minute,
                            secColor: gradBottomColor,
                            primColor: gradTopColor,
                            aspect: aspect);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(bottom: height * 0.35),
                alignment: Alignment.topCenter,
                child: Selector<TimeNotifier, int>(
                    shouldRebuild: (previous, next) => previous != next,
                    selector: (_, timeNot) => timeNot.second,
                    builder: (_, second, __) {
                      return Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          ///accessability feature to get DayName
                          Container(
                              child: CustomPaint(
                                  painter: DigiTalClockPaint(
                                      primColor: gradBottomColor,
                                      secColor: gradTopColor,
                                      second: second,
                                      secondsCirRad: aspect * 18.0,
                                      midCirRad: aspect * 15.0,
                                      dotCirRad: aspect * 12.0))),

                          ///This widget used to animate the seconds text inside the circles painted
                          Semantics(
                              enabled: true,
                              label: Constants.semanticDayName,
                              readOnly: true,
                              value: 'Its ${getTime('EEEE')}',
                              child: Selector<TimeNotifier, String>(
                                  shouldRebuild: (previous, next) =>
                                      previous != next,
                                  selector: (_, timeNot) => timeNot.dayName,
                                  builder: (_, dayName, __) {
                                    return ReusableText(
                                      textName: dayName.toUpperCase(),
                                      alignment: Alignment.center,
                                      fontSize: aspect * 4,
                                      botPadding: aspect * 12,
                                    );
                                  })),
                          SecondsAnimatedWidget(
                              second: second,
                              topColor: gradTopColor,
                              botColor: gradBottomColor,
                              aspect: aspect),

                          ///This only appears when option of 24 hrs format changes in settings icon
                          AnimatedOpacity(
                            duration: Constants.durThree,
                            opacity: timeNotifier.model.is24HourFormat ? 0 : 1,
                            child: TweenAnimationBuilder(
                              duration: Constants.durThree,
                              tween: Tween<double>(
                                  begin: aspect * 15.0, end: aspect * 20.0),
                              builder: (_, padding, __) {
                                return ReusableText(
                                    textName: timeNotifier.amOrpm,
                                    alignment: Constants.cAlign,
                                    fontSize: aspect * 4,
                                    leftPadding: 2,
                                    topPadding: padding);
                              },
                            ),
                          ),
                        ],
                      );
                    }))
          ],
        ));
  }
}

class NeumophicWidget extends StatelessWidget {
  NeumophicWidget({
    Key key,
    @required this.text,
    @required this.primColor,
    @required this.secColor,
    @required this.aspect,
    @required this.width,
    @required this.height,
  }) : super(key: key);

  final String text;
  final Color primColor;
  final Color secColor;

  final double aspect;
  final double width;
  final double height;

  final tween = MultiTrackTween([
    Track("blur")
        .add(Duration(seconds: 1), Tween<double>(begin: 0.2, end: 1.0)),
  ]);

  @override
  Widget build(BuildContext context) {
    print('neumor called...');
    return ControlledAnimation(
      duration: tween.duration,
      tween: tween,
      curve: Curves.easeInBack,
      playback: Playback.MIRROR,
      builder: (
        _,
        anim,
      ) {
        return Container(
          width: width * 0.08,
          height: height * 0.12,
          child: FittedBox(
            fit: BoxFit.contain,
            child: ReusableText(
              textName: '$text',
            ),
          ),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 0.5,
                    color: Colors.white,
                    offset: Offset(1, 0.5),
                    spreadRadius: anim['blur']),
                BoxShadow(
                    blurRadius: 0.5,
                    color: primColor,
                    offset: Offset(0.5, 1),
                    spreadRadius: anim['blur'])
              ],
              color: Color(0xFF060D29),
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle),
          // constraints:
          // BoxConstraints(maxWidth: width * 0.08, maxHeight: height * 0.12),
        );
      },
    );
  }
}

// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';

// import 'package:simple_animations/simple_animations.dart';

// import 'package:flutter_clock_helper/model.dart';
// import 'package:pradeep_manchukonda_clock/utilities/common_funcs.dart';

// import 'package:pradeep_manchukonda_clock/providers/day_notify.dart';
// import 'package:pradeep_manchukonda_clock/constants.dart';
// import 'package:pradeep_manchukonda_clock/seconds_circle_paint.dart';
// import 'package:pradeep_manchukonda_clock/reusable_text.dart';
// import 'package:pradeep_manchukonda_clock/seconds_widget.dart';
// import 'package:provider/provider.dart';

// class DigClock extends StatefulWidget {
//   DigClock({this.gradTopColor, this.gradBottomColor, this.clockModel});
//   final ClockModel clockModel;
//   final gradTopColor;
//   final gradBottomColor;

//   @override
//   _DigClockState createState() => _DigClockState();
// }

// class _DigClockState extends State<DigClock> {
//   DateTime _now;
//   Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     widget.clockModel.addListener(_updateModel);
//     _updateTime();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     widget.clockModel.removeListener(_updateModel);
//     widget.clockModel.dispose();
//     super.dispose();
//   }

//   void _updateModel() {
//     setState(() {});
//   }

//   void _updateTime() {
//     final dayNameNotifier =
//         Provider.of<DayNameNotifier>(context, listen: false);
//     setState(() {
//       _now = DateTime.now();
//       if (_now.hour == 0 && _now.minute == 0 && _now.second == 0)
//         dayNameNotifier.reload('${getTime('EEEE')}');

//       _timer = Timer(
//         Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
//         _updateTime,
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     ///temp variables to display time, dayName.

//     return Semantics(
//       enabled: true,
//       label: Constants.semanticClockTime,
//       readOnly: true,
//       value:
//           'Its ${getTime(Constants.str12HourFormat)} hour ${getTime(Constants.strMins)} minutes ${getTime(Constants.stramOrpm)}',
//       child: Stack(
//         alignment: Constants.cAlign,
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(top: height * 0.07),
//             child: Container(
//               alignment: Alignment.center,
//               // color: Colors.blueGrey,
//               width: width * 0.25,
//               height: height * 0.13,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   NeumophicWidget(
//                       width: width,
//                       height: height,
//                       text: hour,
//                       secColor: widget.gradBottomColor,
//                       primColor: widget.gradTopColor,
//                       aspect: aspect),
//                   SizedBox(
//                     width: width * 0.05,
//                     height: height * 0.8,
//                     child: FittedBox(
//                       fit: BoxFit.contain,
//                       child: ReusableText(
//                         fontSize: aspect * 25,
//                         botPadding: 5,
//                         textName: ':',
//                       ),
//                     ),
//                   ),
//                   NeumophicWidget(
//                       width: width,
//                       height: height,
//                       text: minute,
//                       secColor: widget.gradBottomColor,
//                       primColor: widget.gradTopColor,
//                       aspect: aspect),
//                 ],
//               ),
//             ),
//           ),
//           // SizedBox(
//           //   width: width * 0.1,
//           // ),
//           Container(
//             padding: EdgeInsets.only(bottom: height * 0.35),
//             alignment: Alignment.topCenter,
//             // padding: EdgeInsets.only(left: width * 0.31),
//             child: Stack(
//               alignment: Alignment.center,
//               children: <Widget>[
//                 ///accessability feature to get DayName

//                 ///this paints the circles, next to time

//                 Container(
//                     child: CustomPaint(
//                         painter: DigiTalClockPaint(
//                             primColor: widget.gradBottomColor,
//                             secColor: widget.gradTopColor,
//                             second: _now.second,
//                             secondsCirRad: aspect * 18.0,
//                             midCirRad: aspect * 15.0,
//                             dotCirRad: aspect * 12.0))),

//                 ///This widget used to animate the seconds text inside the circles painted
//                 Semantics(
//                   enabled: true,
//                   label: Constants.semanticDayName,
//                   readOnly: true,
//                   value: 'Its ${getTime('EEEE')}',
//                   child: ReusableText(
//                     textName: dayName.toUpperCase(),
//                     alignment: Alignment.center,
//                     fontSize: aspect * 4,
//                     botPadding: aspect * 12,
//                   ),
//                 ),
//                 SecondsAnimatedWidget(
//                     second: _now.second,
//                     topColor: widget.gradTopColor,
//                     botColor: widget.gradBottomColor,
//                     aspect: aspect),

//                 ///This only appears when option of 24 hrs format changes in settings icon
//                 AnimatedOpacity(
//                   duration: Constants.durThree,
//                   opacity: widget.clockModel.is24HourFormat ? 0 : 1,
//                   child: TweenAnimationBuilder(
//                     duration: Constants.durThree,
//                     tween:
//                         Tween<double>(begin: aspect * 15.0, end: aspect * 20.0),
//                     builder: (_, padding, __) {
//                       return ReusableText(
//                           textName: amOrpm,
//                           alignment: Constants.cAlign,
//                           fontSize: aspect * 4,
//                           leftPadding: 2,
//                           topPadding: padding);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class NeumophicWidget extends StatelessWidget {
//   NeumophicWidget({
//     Key key,
//     @required this.text,
//     @required this.primColor,
//     @required this.secColor,
//     @required this.aspect,
//     @required this.width,
//     @required this.height,
//   }) : super(key: key);

//   final String text;
//   final Color primColor;
//   final Color secColor;

//   final double aspect;
//   final double width;
//   final double height;

//   final tween = MultiTrackTween([
//     Track("blur")
//         .add(Duration(seconds: 1), Tween<double>(begin: 0.2, end: 1.0)),
//     Track("x").add(Duration(seconds: 2), Tween<double>(begin: 0.5, end: 1.0)),
//     Track("y").add(Duration(seconds: 2), Tween<double>(begin: 0.5, end: 1.0)),
//   ]);

//   @override
//   Widget build(BuildContext context) {
//     // print('nuemorphic build...');
//     return ControlledAnimation(
//       duration: tween.duration,
//       tween: tween,
//       curve: Curves.easeInBack,
//       playback: Playback.MIRROR,
//       builder: (
//         _,
//         anim,
//       ) {
//         return Container(
//           width: width * 0.08,
//           height: height * 0.12,
//           child: FittedBox(
//             fit: BoxFit.contain,
//             child: ReusableText(
//               textName: '$text',
//             ),
//           ),
//           decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                     blurRadius: 0.5,
//                     color: Colors.white,
//                     offset: Offset(1, 0.5),
//                     spreadRadius: anim['blur']),
//                 BoxShadow(
//                     blurRadius: 0.5,
//                     color: Random().nextBool() ? primColor : secColor,
//                     offset: Offset(0.5, 1),
//                     spreadRadius: anim['blur'])
//               ],
//               color: Color(0xFF060D29),
//               borderRadius: BorderRadius.circular(10),
//               shape: BoxShape.rectangle),
//           // constraints:
//           // BoxConstraints(maxWidth: width * 0.08, maxHeight: height * 0.12),
//         );
//       },
//     );
//   }
// }
