import 'package:flutter/material.dart';

import 'package:gradient_text/gradient_text.dart';

class GradTextWidget extends StatelessWidget {
  const GradTextWidget({
    Key key,
    @required Color gradBottomColor,
    @required Color gradTopColor,
    @required double textFont,
    @required String text,
  })  : _text = text,
        _textFont = textFont ?? 8.0,
        _gradTopColor = gradTopColor,
        _gradBottomColor = gradBottomColor,
        super(key: key);

  final String _text;
  final double _textFont;
  final Color _gradTopColor;
  final Color _gradBottomColor;

  @override
  Widget build(BuildContext context) {
    return GradientText(
      _text,
      gradient: RadialGradient(
          colors: [_gradBottomColor, _gradTopColor],
          radius: 1,
          tileMode: TileMode.mirror),
      // textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: _textFont,
        fontFamily: 'Rajdhani',
        fontStyle: FontStyle.normal,
      ),
    );
  }
}
