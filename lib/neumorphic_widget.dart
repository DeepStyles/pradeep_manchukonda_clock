import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';

import 'package:pradeep_manchukonda_clock/constants.dart';
import 'package:pradeep_manchukonda_clock/reusable_text.dart';

class NeumorphicWidget extends StatelessWidget {
  NeumorphicWidget({
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
    Track("blur").add(Constants.durOne, Tween<double>(begin: 0.2, end: 1.0)),
  ]);

  @override
  Widget build(BuildContext context) {
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
