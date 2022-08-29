import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/ui/app_layout/app_layout.dart';
import 'package:engagementwallet/src/ui/authentication/signup/complete_profile.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountCreated extends StatefulWidget {
  const AccountCreated({Key? key, this.mainText, this.buttonText,   this.onPressed, this.showFab = false, this.fabText}) : super(key: key);

  final String? mainText;
  final String? buttonText;
  final String? fabText;
  final Function()? onPressed;
  final bool showFab;

  @override
  State<AccountCreated> createState() => _AccountCreatedState();
}

class _AccountCreatedState extends State<AccountCreated> {
  @override
  Widget build(BuildContext context) {
    return AccountBackground(
      showFab: widget.showFab,
      fabText: widget.fabText,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.success),
          kNormalHeight,
          Text( widget.mainText ?? 'Account Created!',
              style: textStyleBig.copyWith(fontSize: 26)),
        //   kNormalHeight,
        // `  ConstrainedBox(
        //     constraints: const BoxConstraints(maxWidth: 300),
        //     child: const Text(
        //         'Provide your active phone number. This would ensure identity verification.',
        //       textAlign: TextAlign.center,
        //     ),
        //   ),`
          kLargeHeight,
          // CustomButton(
          //     text: widget.buttonText ?? "COMPLETE MY PROFILE",
          //     loader: AuthMixin.auth(context, listen: true).isLoading,
          //     onPressed: widget.onPressed ?? () async =>  await AuthMixin.auth(context).startCustomerVerification(
          //         phoneNumber: phoneController.text,
          //         context: context,
          //         verificationPurpose: 'Registration'
          //
          //     )
          // ),
          Padding(
            padding: defaultHPadding,
            child: CustomButton(
              text: widget.buttonText ?? "COMPLETE MY PROFILE",
              loader: false,
              onPressed: widget.onPressed ?? () => navigate(context, AppLayout()),
            ),
          ),

        ],
      ),
    );
  }
}

class AccountBackground extends StatelessWidget {
  const AccountBackground({
    Key? key,
    required this.child, this.showFab = false, this.fabText,
  }) : super(key: key);

  final Widget child;
  final bool showFab;
  final String? fabText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: showFab ? FloatingActionButton(
      //   child: Icon(Icons.arrow_forward, color: whiteColor, size: 30,),
      //   onPressed: () => navigate(context, const AppLayout()),
      // ) : Container(),
      body: Container(
        color: primaryColor,
        child: Padding(
          padding: defaultVPadding,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(Assets.man_2),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(Assets.money),
              ),
              if(showFab)
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 40.h, left: 40, right: 20),
                  child: InkWell(
                    onTap: () => navigate(context, const AppLayout()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(fabText ?? 'Save Account & Continue', style: textStyleSecondary,),
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

              // showFab ? Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Padding(
              //     padding:  EdgeInsets.only(bottom: 40.h, left: 40),
              //     child: Text( fabText ?? 'Save Account & Continue', style: textStyleSecondary,),
              //   ),
              // ) : Container(),
              Center(child: child)
            ],
          ),
        ),
      ),
    );
  }
}
