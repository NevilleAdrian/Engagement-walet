import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';

class BackArrow extends StatelessWidget {
  const BackArrow({
    Key? key, this.onTap,
  }) : super(key: key);

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => popView(context),
      child: Row(
        children: [
          Icon(Icons.arrow_back_ios, color: darkGreyColor, size: 18,),
          Text('Back', style: textStyle400Small.copyWith(color: darkGreyColor),)
        ],
      ),
    );
  }
}
