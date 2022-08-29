import 'package:engagementwallet/src/widgets/logo_text.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';

class HeaderLayout extends StatelessWidget {
  const HeaderLayout({
    Key? key, required this.text, required this.onPressed,
  }) : super(key: key);
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const LogoText(),
        InkWell(
          onTap: onPressed,
          child: Text(text, style: textStyleSecondary),
        )
      ],
    );
  }
}
