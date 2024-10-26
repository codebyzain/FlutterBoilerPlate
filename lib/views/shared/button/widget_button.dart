import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/shared/text/widget_text.dart';

enum ButtonSize { small, medium, large }

enum ButtonShape { square, round, smoothEdge }

class Button extends StatelessWidget {
  final String text;
  final IconData? iconName;
  final double? iconSize;
  final Color? iconColor;
  final Color? color;
  final double? textSize;
  final Color? textColor;
  final ButtonSize? size;
  final double? width;
  final ButtonShape? shape;
  final void Function()? onPress;
  final bool isLoading;
  final double marginVertical;
  final double marginHorizontal;

  const Button(
    this.text, {
    Key? key,
    this.iconName,
    this.width,
    this.iconSize = 17,
    this.iconColor = Colors.white,
    this.color,
    this.textColor = Colors.white,
    this.textSize = 13,
    this.size = ButtonSize.medium,
    this.shape = ButtonShape.smoothEdge,
    this.onPress,
    this.isLoading = false,
    this.marginVertical = 0,
    this.marginHorizontal = 0,
  }) : super(key: key);

  // get borderRadius
  BorderRadiusGeometry getBorderRadius() {
    double borderRadius = 10;
    switch (shape) {
      case ButtonShape.round:
        borderRadius = 50 / 2;
      case ButtonShape.square:
        borderRadius = 0;
      default:
        borderRadius = 10;
    }
    return BorderRadius.all(Radius.circular(borderRadius));
  }

  // calculate the button height
  double getButtonHeight() {
    switch (size) {
      case ButtonSize.small:
        return 32;
      case ButtonSize.large:
        return 50;
      default:
        return 42;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width ?? MediaQuery.of(context).size.width,
      height: getButtonHeight(),
      decoration: BoxDecoration(
        borderRadius: getBorderRadius(),
      ),
      margin: EdgeInsets.symmetric(
        vertical: marginVertical,
        horizontal: marginHorizontal,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: getBorderRadius(),
            ),
          ),
          elevation: MaterialStateProperty.all(1),
          backgroundColor: MaterialStateProperty.all(
            isLoading
                ? Theme.of(context).colorScheme.primary.withOpacity(0.6)
                : color ?? Theme.of(context).colorScheme.primary,
          ),
          overlayColor: MaterialStateProperty.resolveWith(
            (states) {
              return states.contains(MaterialState.pressed)
                  ? isLoading
                      ? null
                      : Colors.white.withOpacity(0.5)
                  : null;
            },
          ),
        ),
        onPressed: isLoading ? () {} : onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Opacity(
                opacity: isLoading ? 0.5 : 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    if (iconName != null)
                      Container(
                        width: 20,
                        padding: const EdgeInsets.only(right: 10),
                        child: Icon(
                          iconName,
                          size: iconSize,
                          color: iconColor,
                        ),
                      ),
                    Expanded(
                      child: TextString(
                        text,
                        bold: true,
                        compact: true,
                        center: true,
                        color: Colors.white,
                      ),
                    ),
                    if (iconName != null && isLoading)
                      Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: const SizedBox(
                          width: 13,
                          height: 13,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        ),
                      )
                    else
                      Container(
                        width: 17,
                      ),
                  ],
                ),
              ),
            ),
            // if (isLoading)
            //   SizedBox(
            //     width: double.infinity,
            //     height: 4,
            //     child: LinearProgressIndicator(
            //       color: color ?? Theme.of(context).colorScheme.primary,
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
