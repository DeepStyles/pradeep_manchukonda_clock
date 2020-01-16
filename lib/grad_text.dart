import 'package:flutter/material.dart';

import 'package:gradient_text/gradient_text.dart';

class GradTextWidget extends StatelessWidget {
  const GradTextWidget({
    Key key,
    @required Color gradBottomColor,
    @required Color gradTopColor,
    @required double textFont,
    @required String text,
    double width,
    double height,
  })  : _text = text,
        _width = width ?? 0,
        _height = height ?? 0,
        _textFont = textFont,
        _gradTopColor = gradTopColor,
        _gradBottomColor = gradBottomColor,
        super(key: key);

  final String _text;
  final double _width;
  final double _height;
  final double _textFont;
  final Color _gradTopColor;
  final Color _gradBottomColor;

  @override
  Widget build(BuildContext context) {
    return GradientText(
      _text,
      gradient: RadialGradient(
          colors: [_gradTopColor, _gradBottomColor],
          radius: 1.5,
          tileMode: TileMode.mirror),
      style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: _textFont,
          // fontFamily: 'Rajdhani',
          fontStyle: FontStyle.normal),
      // textAlign: TextAlign.center
    );
  }
}
