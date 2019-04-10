import 'package:flutter/material.dart';

class RowIncon extends StatelessWidget {
  final Icon icon;
  final String text;
  final Icon iconTextSymbol;
  final double fontSize;
  final FontWeight fontWeight;
  RowIncon(
      {Key key,
      this.icon,
      this.text,
      this.iconTextSymbol,
      this.fontSize,
      this.fontWeight})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        icon,
        Text(
          text,
          style: TextStyle(
              fontSize: fontSize, color: Colors.white, fontWeight: fontWeight),
        ),
        iconTextSymbol,
      ],
    );
  }
}
