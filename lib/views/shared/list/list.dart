import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/shared/text/widget_text.dart';

class ListItem extends StatelessWidget {
  final String text;
  final String? description;
  final Color? color;
  final double marginVertical;
  final double marginHorizontal;
  final void Function()? onPress;
  final IconData? iconName;
  final double? iconSize;
  final Color? iconColor;

  const ListItem(
    this.text, {
    Key? key,
    this.color,
    this.marginVertical = 0,
    this.marginHorizontal = 0,
    this.description,
    this.onPress,
    this.iconName,
    this.iconSize = 24,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: iconName != null
          ? SizedBox(
              width: 15,
              child: Icon(
                iconName,
                size: iconSize,
                color: iconColor ?? Theme.of(context).iconTheme.color,
              ),
            )
          : null,
      title: TextString(
        text,
        bold: true,
        size: 14,
      ),
      dense: true,
      tileColor: color,
      contentPadding: EdgeInsets.symmetric(
        vertical: marginVertical,
        horizontal: marginHorizontal,
      ),
      subtitle: description != null
          ? Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Opacity(
                opacity: 0.8,
                child: TextString(
                  "$description",
                  size: 13,
                ),
              ),
            )
          : null,
    );
  }
}
