import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';

import 'package:pradeep_manchukonda_clock/grad_text.dart';
import 'package:pradeep_manchukonda_clock/utils.dart';

class SecondsAnimatedWidget extends StatelessWidget {
  SecondsAnimatedWidget({
    Key key,
    @required int second,
    @required Color topColor,
    @required Color botColor,
    @required this.aspect,
  })  : _second = second,
        _topColor = topColor,
        _botColor = botColor,
        super(key: key);

  final int _second;
  final Color _topColor;
  final Color _botColor;
  final double aspect;

  final tween = MultiTrackTween([
    Track("opacity")
        .add(Duration(milliseconds: 700), Tween<double>(begin: 0, end: 1.0)),
    Track("translate").add(Duration(milliseconds: 700),
        Tween(begin: Offset(0, -0.5), end: Offset(0, 0))),
  ]);

  @override
  Widget build(BuildContext context) {
    return

        ///This animates seconds text in loop by translating and changing opacity
        ControlledAnimation(
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
                    gradTopColor: _topColor,
                    gradBottomColor: _botColor,
                    textFont: aspect * 12,
                  ),
                ),
                opacity: anim['opacity'],
              );
            });
  }
}
