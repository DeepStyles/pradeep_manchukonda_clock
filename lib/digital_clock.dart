import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:pradeep_manchukonda_clock/utilities/common_funcs.dart';
import 'package:pradeep_manchukonda_clock/widgets/neumorphic_widget.dart';
import 'package:pradeep_manchukonda_clock/utilities/constants.dart';
import 'package:pradeep_manchukonda_clock/seconds_circle_paint.dart';
import 'package:pradeep_manchukonda_clock/providers/time_notify.dart';
import 'package:pradeep_manchukonda_clock/widgets/reusable_text.dart';
import 'package:pradeep_manchukonda_clock/widgets/seconds_widget.dart';

class DigClock extends StatelessWidget {
  const DigClock({this.clockModel});

  final clockModel;

  @override
  Widget build(BuildContext context) {
    final timeNotifier = Provider.of<TimeNotifier>(context, listen: false);
    final media = MediaQuery.of(context);
    final safeAreaHor = media.padding.left + media.padding.right;
    final safeAreaVer = media.padding.top + media.padding.bottom;
    final aspect = media.size.aspectRatio;
    final width = media.size.width - safeAreaHor;
    final height = media.size.height - safeAreaVer;
    timeNotifier.check24HourFormat(clockModel.is24HourFormat);

    return Semantics(
        enabled: true,
        label: Constants.semanticClockTime,
        readOnly: true,
        value:
            'Its ${getTime(Constants.str12HourFormat)} hour ${getTime(Constants.strMins)} minutes ${getTime(Constants.stramOrpm)}',
        child: Selector<TimeNotifier, Color>(
            shouldRebuild: (previous, next) => previous != next,
            selector: (_, timeNotifier) => timeNotifier.gradTopColor,
            builder: (_, gradTopColor, __) {
              // final gradBottomColor = timeNotifier.gradBottomColor;
              return Stack(
                alignment: Constants.cAlign,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: height * 0.07),
                    child: Container(
                      alignment: Alignment.center,
                      width: width * 0.25,
                      height: height * 0.13,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Selector<TimeNotifier, String>(
                            shouldRebuild: (previous, next) => previous != next,
                            selector: (_, timeNotifier) => timeNotifier.hour,
                            builder: (_, hour, __) {
                              return NeumorphicWidget(
                                  width: width,
                                  height: height,
                                  text: hour,
                                  secColor: timeNotifier.gradBottomColor,
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
                              return NeumorphicWidget(
                                  width: width,
                                  height: height,
                                  text: minute,
                                  secColor: timeNotifier.gradBottomColor,
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
                                Container(
                                    child: CustomPaint(
                                        painter: DigiTalClockPaint(
                                            primColor:
                                                timeNotifier.gradBottomColor,
                                            secColor: timeNotifier.gradTopColor,
                                            second: second,
                                            secondsCirRad: aspect * 18.0,
                                            midCirRad: aspect * 15.0,
                                            dotCirRad: aspect * 12.0))),

                                ///accessability feature to get DayName

                                Semantics(
                                    enabled: true,
                                    label: Constants.semanticDayName,
                                    readOnly: true,
                                    value: 'Its ${getTime('EEEE')}',
                                    child: Selector<TimeNotifier, String>(
                                        shouldRebuild: (previous, next) =>
                                            previous != next,
                                        selector: (_, timeNot) =>
                                            timeNot.dayName,
                                        builder: (_, dayName, __) {
                                          return ReusableText(
                                            textName: dayName.toUpperCase(),
                                            alignment: Alignment.center,
                                            fontSize: aspect * 3.5,
                                            botPadding: aspect * 12,
                                          );
                                        })),

                                ///This widget used to animate the seconds text inside the circles painted
                                SecondsAnimatedWidget(
                                    second: second,
                                    topColor: gradTopColor,
                                    botColor: timeNotifier.gradBottomColor,
                                    aspect: aspect),

                                ///This only appears when option of 24 hrs format changes in settings icon
                                AnimatedOpacity(
                                  duration: Constants.durThree,
                                  opacity:
                                      timeNotifier.model.is24HourFormat ? 0 : 1,
                                  child: TweenAnimationBuilder(
                                    duration: Constants.durThree,
                                    tween: Tween<double>(
                                        begin: aspect * 8.0,
                                        end: aspect * 13.0),
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
              );
            }));
  }
}
