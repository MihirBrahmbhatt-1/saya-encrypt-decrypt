import 'package:flutter/material.dart';

import '../const/app_constants.dart';
import 'custom_text_widget.dart';

class CustomElevatedButton extends StatefulWidget {
  final String? title;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final double? height;
  final double? width;
  final bool? isLoading;
  final bool? isFontBold;

  final Color textColor;
  final Color? borderColor;
  final Color? backgroundColor;

  const CustomElevatedButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.height,
    this.width = 150,
    required this.textColor,
    this.borderColor,
    this.onLongPress,
    this.isLoading,
    required this.backgroundColor,
    this.isFontBold,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: buttonBorderRadius,
          ),
        ),
        onPressed: widget.isLoading == true ? null : widget.onPressed,
        child: widget.isLoading == true
            ? Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: widget.textColor,
                  ),
                ),
              )
            : GlobalTextUIWidget(
                textString: widget.title.toString(),
                textSize: FontSize().regular,
                textCenter: true,
                isFontBold: widget.isFontBold ?? true,
                fontColor: widget.textColor,
                isFontUnderline: false,
              ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomIconButton extends StatefulWidget {
  String? title;
  VoidCallback onPressed;
  Color? color;
  Icon icon;
  final double? height;
  final double? width;

  final bool? isLoading;

  final Color textColor;
  final Color? borderColor;
  final Color? backgroundColor;

  CustomIconButton({
    super.key,
    this.color,
    required this.title,
    required this.onPressed,
    required this.icon,
    this.width,
    this.height,
    required this.textColor,
    this.borderColor,
    this.backgroundColor,
    this.isLoading,
  });

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 45,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(widget.backgroundColor),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: buttonBorderRadius,
            ),
          ),
        ),
        label: widget.isLoading == true
            ? Center(
                child: SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(
                    color: widget.textColor,
                  ),
                ),
              )
            : GlobalTextUIWidget(
                textString: widget.title.toString(),
                textSize: FontSize().medium,
                isFontBold: true,
                fontColor: widget.textColor,
                isFontUnderline: false,
              ),
        icon: widget.isLoading == false ? widget.icon : null,
        onPressed: widget.onPressed,
      ),
    );
  }
}

class CustomTextButton extends StatefulWidget {
  final String? title;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final bool? isLoading;
  final bool? isUnderline;
  final bool isEnable;
  final double? height;
  final double? width;

  final Color textColor;
  final Color? borderColor;
  final Color? backgroundColor;

  final Key? buttonKey;

  // ignore: prefer_const_constructors_in_immutables
  CustomTextButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.textColor,
    this.borderColor,
    this.onLongPress,
    this.isLoading,
    this.backgroundColor,
    this.isUnderline,
    this.isEnable = true,
    this.buttonKey,
    this.height,
    this.width,
  });

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        overlayColor: WidgetStatePropertyAll(widget.backgroundColor),
        splashColor: widget.backgroundColor,
        highlightColor: widget.backgroundColor,
        hoverColor: widget.backgroundColor,
        enableFeedback: false,
        key: widget.buttonKey ?? Key('buttonKey'),
        onTap: widget.isEnable ? widget.onPressed : null,
        child: GlobalTextUIWidget(
          textString: widget.title.toString(),
          textSize: FontSize().regular,
          isFontBold: false,
          fontColor: widget.textColor,
          textCenter: true,
          isFontUnderline: widget.isUnderline ?? false,
        ),
      ),
    );
  }
}
