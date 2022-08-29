import 'package:engagementwallet/src/ui/app_layout/app_layout.dart';
import 'package:engagementwallet/src/ui/authentication/signup/referral.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SetupComplete extends StatefulWidget {
  const SetupComplete({Key? key}) : super(key: key);

  @override
  State<SetupComplete> createState() => _SetupCompleteState();
}

class _SetupCompleteState extends State<SetupComplete> {
  @override
  Widget build(BuildContext context) {
    return SetupBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          kLargeHeight,
          SvgPicture.asset(Assets.success,color: secondaryColor,),
          kNormalHeight,
          Text('Setup Complete!',
              style: textStyleBig.copyWith(fontSize: 26)),
          // kSmallHeight,
          // ConstrainedBox(
          //   constraints: const BoxConstraints(maxWidth: 300),
          //   child: const Text(
          //     'Provide your active phone number. This would ensure identity verification.',
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          kLargeHeight,
          InkWell(
            onTap: () => navigate(context, const ReferralScreen()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               Row(
                 children: [
                   SvgPicture.asset(Assets.box),
                   kSmallWidth,
                   Text('Refer and earn bonuses', style: textStyle400Small,)
                 ],
               ),
                Icon(Icons.arrow_forward, color: accentColor,)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SetupBackground extends StatelessWidget {
  const SetupBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   child: ,
      //   onPressed: () => navigate(context, const AppLayout()),
      // ),
      body: Container(
        color: primaryColor,
        child: Padding(
          padding: defaultVPadding,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: SvgPicture.asset(Assets.rocket),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 40.h, left: 40, right: 20),
                  child: InkWell(
                    onTap: () => navigate(context, const AppLayout()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Go to Dashboard Instead', style: textStyleSecondary,),
                        kSmallWidth,
                        CircleAvatar(
                          backgroundColor: secondaryColor,
                          radius: 30,
                          child: Icon(Icons.arrow_forward, color: whiteColor, size: 30,),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: defaultVHPadding,
                  child: child)
            ],
          ),
        ),
      ),
    );
  }
}
