import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/shared/text/widget_text.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum TextInputMode { flat, fill }

class TextInput extends StatefulWidget {
  final String? placeholder;
  final IconData? iconName;
  final double? iconSize;
  final Color? iconColor;
  final Color? color;
  final double? textSize;
  final Color? textColor;
  final double? width;
  final bool isLoading;
  final double marginVertical;
  final double marginHorizontal;
  final String? formatter;
  final Map<String, RegExp>? filter;
  final TextInputType? type;
  final TextInputMode? mode;
  final String? label;

  const TextInput({
    Key? key,
    this.placeholder,
    this.iconName,
    this.width,
    this.iconSize = 19,
    this.iconColor,
    this.color,
    this.textColor,
    this.textSize,
    this.isLoading = false,
    this.marginVertical = 0,
    this.marginHorizontal = 0,
    this.formatter,
    this.filter,
    this.type = TextInputType.text,
    this.mode = TextInputMode.flat,
    this.label,
  }) : super(key: key);
  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    final maskFormatter = MaskTextInputFormatter(
      mask: widget.formatter,
      filter: widget.filter,
      type: MaskAutoCompletionType.lazy,
    );
    return Column(
      children: [
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(
              bottom: widget.mode == TextInputMode.fill ? 10 : 0,
            ),
            child: Opacity(
              opacity: 0.6,
              child: TextString(
                widget.label ?? "",
                size: 12,
                style: FontStyle.italic,
              ),
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: widget.mode == TextInputMode.fill
                ? widget.color ?? Theme.of(context).colorScheme.secondary
                : null,
            borderRadius: widget.mode == TextInputMode.fill
                ? BorderRadius.circular(12)
                : null,
            border: widget.mode == TextInputMode.flat
                ? Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .color
                              ?.withOpacity(0.3) ??
                          Theme.of(context).colorScheme.secondary,
                    ),
                  )
                : null,
          ),
          height: 50,
          padding: EdgeInsets.only(
            left: widget.mode == TextInputMode.flat ? 0 : 12,
            right: widget.mode == TextInputMode.flat ? 0 : 12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.iconName != null)
                Container(
                  // padding: const EdgeInsets.only(top: 3),
                  alignment: Alignment.centerLeft,
                  width: 28,
                  child: Icon(
                    widget.iconName,
                    size: widget.iconSize,
                    color: widget.iconColor ??
                        Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
              Expanded(
                child: TextFormField(
                  inputFormatters: [maskFormatter],
                  keyboardType: widget.type,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontSize: widget.textSize ?? 15,
                    height: 0,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0,
                    ),
                    border: InputBorder.none,
                    fillColor: Theme.of(context).textTheme.bodyMedium!.color,
                    hintText: widget.placeholder,
                    hintStyle: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .color!
                          .withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              if (widget.isLoading)
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 5, top: 3),
                  child: SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      color: widget.textColor ??
                          Theme.of(context).textTheme.bodyMedium!.color,
                      strokeWidth: 2,
                    ),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
