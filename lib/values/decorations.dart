import 'package:engagementwallet/src/utils/colors.dart';
import 'package:flutter/material.dart';

BoxDecoration get pinPutDecoration {
  return BoxDecoration(
    color: lightGreyColor,
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(
      width: 0.5,
      color: secondaryColor,
    ),
  );
}