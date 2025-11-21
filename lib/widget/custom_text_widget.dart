import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../const/app_colors.dart';


class GlobalTextUIWidget extends StatelessWidget {
  final String textString;
  final double? textSize;
  final bool isFontBold;
  final bool isFontUnderline;
  final Color fontColor;
  final bool textCenter;
  final bool isTextRight;
  final int numberOfLines;
  final FontStyle fontStyle;
  final TextStyle? style;

  GlobalTextUIWidget({
    super.key,
    required this.textString,
    this.textSize,
    this.isFontBold = false,
    this.isFontUnderline = false,
    this.fontColor = AppColors.black,
    this.textCenter = false,
    this.isTextRight = false,
    this.numberOfLines = 5,
    this.fontStyle = FontStyle.normal,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textString,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      maxLines: numberOfLines,
      textAlign: isTextRight
          ? TextAlign.right
          : textCenter
              ? TextAlign.center
              : TextAlign.start,
      style: style ??
          GoogleFonts.roboto(
            textStyle: TextStyle(
              decoration: isFontUnderline
                  ? TextDecoration.underline
                  : TextDecoration.none,
              decorationColor: isFontUnderline ? fontColor : null,
              fontSize: textSize,
              fontWeight: isFontBold ? FontWeight.bold : FontWeight.normal,
              letterSpacing: .2,
              fontStyle: fontStyle,
              color: fontColor,
            ),
          ),
    );
  }
}
