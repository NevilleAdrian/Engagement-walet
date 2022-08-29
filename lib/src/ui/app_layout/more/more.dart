import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/ui/app_layout/home/home.dart';
import 'package:engagementwallet/src/ui/app_layout/more/friends/friends.dart';
import 'package:engagementwallet/src/ui/app_layout/more/profile_settings/profile_settings.dart';
import 'package:engagementwallet/src/ui/app_layout/more/saved_banks/saved_banks.dart';
import 'package:engagementwallet/src/ui/app_layout/more/security_settings/security_settings.dart';
import 'package:engagementwallet/src/ui/app_layout/more/support/support.dart';
import 'package:engagementwallet/src/ui/app_layout/more/transactions/transactions.dart';
import 'package:engagementwallet/src/ui/authentication/login/login.dart';
import 'package:engagementwallet/src/ui/authentication/signup/referral.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../values/padding.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: defaultHPadding.copyWith(bottom: 0, top: 0),
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('MORE FOR YOU',
                            style: textStyle600Small.copyWith(
                                fontSize: 18, color: darkPrimaryColor)),
                        kSmallHeight,
                        ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 260),
                            child: Text(
                                'Change settings on app via this page',
                                style: textStyle400Small))
                      ],
                    ),
                  ),
                  kSmallWidth,
                  SvgPicture.asset(Assets.flower)
                ],
              ),
            ),
            Padding(
              padding: defaultVHPadding.copyWith(bottom: 30),
              child: Column(
                children: [
                  ProfileItems(
                    image: Assets.profile,
                    mainText: "Profile Settings",
                    subText:
                        'Edit profile settings at any time',
                    onTap: () => openDialog(context, const ProfileSettings()),
                  ),
                  ProfileItems(
                    image: Assets.security,
                    mainText: "Security Settings",
                    subText:
                        'Change Security settings ',
                    onTap: () => openDialog(context, const SecuritySettings()),
                  ),
                  ProfileItems(
                    image: Assets.transactions,
                    mainText: "Transactions",
                    subText:
                        'View Transactions made over a period',
                    onTap: () => openDialog(context, const Transaction()),
                  ),
                  ProfileItems(
                    image: Assets.refer,
                    mainText: "Refer & Earn",
                    subText:
                        'Refer people and earn a reward',
                    onTap: () => navigate(context, const ReferralScreen()),
                  ),
                  ProfileItems(
                    image: Assets.friend,
                    mainText: "Friend List",
                    subText:
                        'Add new friends',
                    onTap: () => openDialog(context, const ShowFriends()),
                  ),
                  // ProfileItems(
                  //   image: Assets.virtual,
                  //   mainText: "Virtual Card",
                  //   subText:
                  //       'Use fingerprint or face ID to login and perform transactions',
                  //   onTap: () => openDialog(context, const ShowFriends()),
                  // ),
                  ProfileItems(
                    image: Assets.saved_banks,
                    mainText: "Saved Beneficiary",
                    subText:
                        'View all saved beneficiaries',
                    onTap: () => openDialog(context, const SavedBanks()),
                  ),
                  ProfileItems(
                    image: Assets.support,
                    mainText: "Support",
                    subText:
                        'Contact us to help you',
                    onTap: () => openDialog(context, const Support()),

                  ),
                  Center(
                    child: InkWell(
                      onTap: () => AuthMixin.auth(context).logout(context),
                      child: Text(
                        'Logout',
                        style: textStyle400Small.copyWith(color: Colors.red),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileItems extends StatelessWidget {
  const ProfileItems({
    Key? key,
    this.image,
    this.mainText,
    this.subText,
    this.onTap,
  }) : super(key: key);

  final String? image;
  final String? mainText;
  final String? subText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(image!),
                  kVerySmallWidth,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mainText!,
                        style: textStyle600Small,
                      ),
                      kVerySmallHeight,
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: Text(
                          subText!,
                          style:
                              textStyle400Small.copyWith(color: darkGreyColor),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Icon(Icons.chevron_right)
            ],
          ),
        ),
        SpaceDivider(
          height: 40,
        )
      ],
    );
  }
}
