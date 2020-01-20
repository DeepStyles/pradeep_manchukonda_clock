import 'package:flutter/material.dart';

import 'package:pradeep_manchukonda_clock/constants.dart';

class ReusableText extends StatelessWidget {
  ReusableText({
    Key key,
    this.fontSize,
    @required this.textName,
    this.fontFamily = 'Rajdhani',
    this.alignment = Alignment.center,
    this.topPadding = 0,
    this.rightPadding = 0,
    this.botPadding = 0,
    this.leftPadding = 0,
  }) : super(key: key);

  final textName;
  final alignment;
  final fontSize;
  final double rightPadding;
  final String fontFamily;
  final double topPadding;
  final double botPadding;
  final double leftPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: topPadding,
          bottom: botPadding,
          left: leftPadding,
          right: rightPadding),
      child: Align(
          alignment: alignment,
          child: Text(textName,
              style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: fontSize,
                  color: Constants.whiteColor))),
    );
  }
}
