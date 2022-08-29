import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoText extends StatelessWidget {
  const LogoText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(Assets.logo),
        kVerySmallWidth,
        Text(
          'Company Logo',
          style: textStyle600Small,
        ),
      ],
    );
  }
}
