import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:flutter/material.dart';

class SpaceDivider extends StatelessWidget {
  const SpaceDivider({
    Key? key, this.height, this.color,
  }) : super(key: key);

  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        height == null ? kSmallHeight : Container(),
         Divider(
           color: color ?? greyColor,
          thickness: 0.7,
          height: height ?? 40,
        )
      ],
    );
  }
}
