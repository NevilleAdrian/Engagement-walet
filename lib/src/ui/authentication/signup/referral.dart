import 'package:clipboard/clipboard.dart';
import 'package:engagementwallet/src/ui/authentication/signup/contacts/contacts.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/backgrounds/authentication_backgrounds.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({Key? key}) : super(key: key);

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      bottomNavigationBar: Container(
        padding: defaultPadding,
        child: Container(
          child: CustomButton(
              text: "SHARE TO CONTACT", onPressed: ()  => null),
        ),
      ),
      body: AuthenticationBackGround(
        padding: EdgeInsets.zero,
        height: 1.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: defaultVHPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () => popView(context),
                          child: SvgPicture.asset(Assets.close)),
                      Image.asset(Assets.memoji),
                      SvgPicture.asset(
                        Assets.close,
                        color: whiteColor,
                      )
                    ],
                  ),
                  kNormalHeight,
                  Text(
                    'Get rewarded for your referral',
                    style: textStyle600Small.copyWith(fontSize: 24),
                  ),
                  kSmallHeight,
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Spread love to people around you and\n",
                        style: textStyle14Small,
                        children: [
                          TextSpan(text: "earn ", style: textStyle14Small),
                          TextSpan(
                              text: "₦30",
                              style: textStyle14Small.copyWith(
                                  color: secondaryColor)),
                          TextSpan(
                              text: " per referral.", style: textStyle14Small),
                        ]),
                  ),
                ],
              ),
            ),
            const SpaceDivider(),
            Center(
                child: Text('SHARE LINK ON SOCIAL MEDIA',
                    style: textStyleSecondary)),
            kSmallHeight,
            Padding(
              padding: defaultHBIGPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    Assets.instagram,
                  ),
                  SvgPicture.asset(
                    Assets.whatsapp,
                  ),
                  SvgPicture.asset(
                    Assets.twitter,
                  ),
                  SvgPicture.asset(
                    Assets.facebook,
                  ),
                  SvgPicture.asset(
                    Assets.message,
                  ),
                ],
              ),
            ),
            const SpaceDivider(),
            Padding(
              padding: defaultHPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Referral link', style: textStyle400Small),
                  kSmallHeight,
                  Container(
                    padding: defaultPadding,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: otherColor,
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    child: Text(
                      'figma.com/file/iV6xtqGzqEf6uf5lloe...',
                      overflow: TextOverflow.ellipsis,
                      style: textStyleSecondary,
                    ),
                  )
                ],
              ),
            ),
            kSmallHeight,
            InkWell(
              onTap: () => copy('figma.com/file/iV6xtqGzqEf6uf5lloe...'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.copy_sharp, color: secondaryColor),
                  kVerySmallWidth,
                  Text(
                    'Copy Link',
                    style: textStyleSecondary,
                  )
                ],
              ),
            )
          ],
        ),
        secondChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [PhoneContacts()],
        ),
      ),
    );
  }
}
