import 'dart:core';

import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart';

import 'package:flutter_clock_helper/model.dart';

import 'package:pradeep_manchukonda_clock/constants.dart';
import 'package:pradeep_manchukonda_clock/digital_clock.dart';
import 'package:pradeep_manchukonda_clock/providers/day_notify.dart';
import 'package:pradeep_manchukonda_clock/utils.dart';
import 'package:provider/provider.dart';

class PradeepClock extends StatelessWidget {
  ///injecting clock model
  const PradeepClock(this.model);

  final ClockModel model;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => DayNameNotifier(),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ///Flare widget to play animations
            FlareClockWidget(),

            ///initial scaling animation of time
            TweenAnimationBuilder<double>(
              curve: Constants.curveBounce,
              tween: Tween<double>(begin: 0, end: 1),
              builder: (_, scaleValue, __) {
                return Transform.scale(
                    child: DigClock(
                      clockModel: model,
                      gradTopColor: Constants
                          .colorMap['${getTime('EEEE').toLowerCase()}Top'],
                      gradBottomColor: Constants
                          .colorMap['${getTime('EEEE').toLowerCase()}Bottom'],
                    ),
                    scale: scaleValue);
              },
              duration: Constants.scaleDur,
            ),
          ],
        ));
  }
}

class FlareClockWidget extends StatelessWidget {
  const FlareClockWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DayNameNotifier>(builder: (_, dayNameNotifier, __) {
      return FlareActor(
        Constants.assetPath,
        alignment: Constants.cAlign,
        fit: BoxFit.cover,
        animation: '${dayNameNotifier.getDayName}',
      );
    });
  }
}
