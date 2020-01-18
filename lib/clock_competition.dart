import 'dart:core';

import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:pradeep_manchukonda_clock/constants.dart';
import 'package:pradeep_manchukonda_clock/digital_clock.dart';
import 'package:pradeep_manchukonda_clock/utils.dart';

class PradeepClock extends StatelessWidget {
  ///injecting clock model
  const PradeepClock(this.model);

  final ClockModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ///Flare widget to play animations
        FlareActor(
          Constants.assetPath,
          alignment: Constants.cAlign,
          fit: BoxFit.cover,
          animation: '${getTime('EEEE').toLowerCase()}',
        ),

        ///initial scaling animation of time
        TweenAnimationBuilder(
          curve: Constants.curveBounce,
          tween: Tween<double>(begin: 0, end: 1),
          builder: (_, scaleValue, __) {
            return Transform.scale(
                child: DigClock(
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
