import 'package:flutter/material.dart';
import 'package:flutter_emoji/utils/colors_utils.dart';
import 'package:flutter_emoji/utils/font_utils.dart';

class CustomButton extends StatelessWidget {
  final String btnName;
  final VoidCallback? callback;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final double height;
  final double width;
  final double fontsize;
  final FontWeight? fontWeight;
  final bool disabled;
  final EdgeInsetsGeometry margin;

  const CustomButton(
      {super.key,
      required this.btnName,
      required this.callback,
      this.bgColor = AppColors.primaryColor,
      this.borderColor = AppColors.primaryColor,
      this.textColor = AppColors.white,
      this.height = 45,
      this.width = double.infinity,
      this.fontsize = 16.0,
      this.fontWeight = FontWeight.w500,
      this.disabled = false,
      this.margin = const EdgeInsets.all(0)});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        disabled ? null : callback!();
      },
      child: Container(
          margin: margin,
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: bgColor,
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              btnName,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: fontWeight,
                  fontSize: fontsize,
                  color: textColor,
                  fontFamily: Fonts.normal,
                  letterSpacing: 1.1),
            ),
          )),
    );
  }
}
