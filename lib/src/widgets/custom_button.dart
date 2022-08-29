

import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../values/radii.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color? color;
  final bool? loader;


  const CustomButton(
      {Key? key, required this.text, required this.onPressed, this.color, this.loader  = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color ?? secondaryColor,
        border: Border.all(color: color ?? secondaryColor),
        borderRadius: Radii.k10pxRadius,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: loader! ? circularProgressIndicator()  : Text(
          text,
          style: textStyle400Small.copyWith(color: whiteColor),
          textAlign: TextAlign.center,
        ),
        style: TextButton.styleFrom(
          // ignore: unnecessary_null_comparison
          backgroundColor: onPressed != null
              ? (color ?? secondaryColor)
              : (color ?? secondaryColor.withOpacity(0.5)),
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 1),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
class CustomWidgetButton extends StatelessWidget {
  final Widget widget;
  final Function() onPressed;
  final Color? color;
  final double? height;

  const CustomWidgetButton(
      {Key? key, required this.widget, required this.onPressed, this.color, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 56,
      // width: double.infinity,
      decoration: BoxDecoration(
        color: color ?? secondaryColor,
        border: Border.all(color: color ?? secondaryColor),
        borderRadius: Radii.k10pxRadius,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: widget,
        style: TextButton.styleFrom(
          // ignore: unnecessary_null_comparison
          backgroundColor: onPressed != null
              ? (color ?? secondaryColor)
              : (color ?? secondaryColor.withOpacity(0.5)),
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 1),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}

class InactiveCustomButton extends StatelessWidget {
  final String text;

  // final Function() onPressed;

  const InactiveCustomButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(.1),
        border: Border.all(color: primaryColor.withOpacity(.1)),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          text,
          style: GoogleFonts.mulish(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 18,
          ),
        ),
        style: TextButton.styleFrom(
          // ignore: unnecessary_null_comparison
          backgroundColor: primaryColor.withOpacity(0.5),
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 1),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
