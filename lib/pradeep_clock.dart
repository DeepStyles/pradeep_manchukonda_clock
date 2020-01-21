import 'dart:core';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_clock_helper/model.dart';

import 'package:pradeep_manchukonda_clock/providers/time_notify.dart';
import 'package:pradeep_manchukonda_clock/utilities/constants.dart';
import 'package:pradeep_manchukonda_clock/digital_clock.dart';

class MyClock extends StatelessWidget {
  ///injecting clock model
  const MyClock(this.model);

  final ClockModel model;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TimeNotifier(model),
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
    return Selector<TimeNotifier, String>(
        shouldRebuild: (previous, next) => previous != next,
        selector: (_, timeNotifier) => timeNotifier.dayName,
        builder: (_, dayName, __) {
          return FlareActor(
            Constants.assetPath,
            alignment: Constants.cAlign,
            fit: BoxFit.cover,
            animation: '$dayName',
          );
        });
  }
}
