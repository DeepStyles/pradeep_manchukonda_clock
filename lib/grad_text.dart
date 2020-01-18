import 'package:flutter/material.dart';

import 'package:gradient_text/gradient_text.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class GradTextWidget extends StatelessWidget {
  const GradTextWidget({
    Key key,
    @required Color gradBottomColor,
    @required Color gradTopColor,
    @required double textFont,
    @required String text,
    @required String fontFamily,
  })  : _text = text,
        _fontFamily = fontFamily ?? 'Rajdhani',
        _textFont = textFont,
        _gradTopColor = gradTopColor,
        _gradBottomColor = gradBottomColor,
        super(key: key);

  final String _fontFamily;
  final String _text;
  final double _textFont;
  final Color _gradTopColor;
  final Color _gradBottomColor;

  @override
  Widget build(BuildContext context) {
    return
        // RotateAnimatedTextKit(text: [],);

        GradientText(
      _text,
      gradient: RadialGradient(
          colors: [_gradBottomColor, _gradTopColor],
          radius: 1,
          tileMode: TileMode.mirror),
      style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: _textFont,
          fontFamily: _fontFamily,
          fontStyle: FontStyle.normal),
      // textAlign: TextAlign.center
    );
  }
}
