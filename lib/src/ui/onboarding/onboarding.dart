import 'package:engagementwallet/src/ui/authentication/login/login.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/backgrounds/onboarding_background.dart';
import 'package:engagementwallet/src/widgets/logo_text.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return OnBoardinglayout(
      showLayout: true,
      child: SafeArea(
        child: Padding(
          padding: defaultVHPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LogoText(),
              kVeryLargeHeight,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(Assets.welcome),
                  kNormalHeight,
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 310),
                    child: Text(
                      'Your all-in-one wallet engagement platform',
                      style: textStyleBig,
                    ),
                  ),
                  // kNormalHeight,
                  // ConstrainedBox(
                  //   constraints: const BoxConstraints(maxWidth: 240),
                  //   child: Text('In efforts to expand our horizons, we welcome every investment-minded individual.',
                  //     style: textStyle400Small,),
                  // ),
                  kSmallHeight,
                  InkWell(
                    onTap: () => navigate(context, const LoginScreen()),
                    child: CircleAvatar(radius: 30,
                      backgroundColor: secondaryColor,
                      child: Icon(Icons.arrow_forward_outlined, color: whiteColor,),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


