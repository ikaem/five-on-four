// TODO this might exist native, but lets test this
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextStyle? textStyle;

  const TextWithIcon({
    Key? key,
    required this.text,
    required this.icon,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final textColor = color ?? Colors.black;
    final styleOfText = textStyle ?? Theme.of(context).textTheme.bodyMedium;

    return Row(
      children: <Widget>[
        Icon(icon),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: styleOfText,
        )
      ],
    );
  }
}
