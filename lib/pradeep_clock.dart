import 'dart:core';

import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart';

import 'package:flutter_clock_helper/model.dart';
import 'package:pradeep_manchukonda_clock/providers/time_notify.dart';
import 'package:pradeep_manchukonda_clock/utilities/common_funcs.dart';

import 'package:pradeep_manchukonda_clock/constants.dart';
import 'package:pradeep_manchukonda_clock/digital_clock.dart';
import 'package:pradeep_manchukonda_clock/providers/day_notify.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MyClock extends StatelessWidget {
  ///injecting clock model
  const MyClock(this.model);

  final ClockModel model;

  @override
  Widget build(BuildContext context) {
    print('pradeep clock build...');
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(
          create: (_) => DayNameNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => TimeNotifier(model),
        )
      ],
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
      ),
    );
  }
}

class FlareClockWidget extends StatelessWidget {
  const FlareClockWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('flare clock build...');

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
