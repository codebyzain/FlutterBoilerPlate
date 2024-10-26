import 'package:flutter/material.dart';

class TextString extends StatelessWidget {
  final String text;
  final bool bold;
  final bool compact;
  final bool center;
  final double? size;
  final Color? color;
  final FontStyle? style;

  const TextString(
    this.text, {
    Key? key,
    this.bold = false,
    this.size,
    this.compact = false,
    this.color,
    this.center = false,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: compact ? 1 : null,
      overflow: compact ? TextOverflow.ellipsis : null,
      textAlign: center ? TextAlign.center : null,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            fontSize: size,
            color: color,
            height: 1.4,
            fontStyle: style,
          ),
    );
  }
}
