import 'package:flutter/material.dart';

import 'package:pradeep_manchukonda_clock/constants.dart';

class ReusableText extends StatelessWidget {
  ReusableText({
    Key key,
    @required this.fontSize,
    @required this.textName,
    @required this.alignment,
    this.topPadding = 0,
    this.botPadding = 0,
    this.leftPadding = 0,
  }) : super(key: key);

  final String textName;
  final double topPadding;
  final double botPadding;
  final double leftPadding;
  final alignment;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: topPadding, bottom: botPadding, left: leftPadding),
      child: Align(
          alignment: alignment,
          child: Text(textName,
              style:
                  TextStyle(fontSize: fontSize, color: Constants.whiteColor))),
    );
  }
}
