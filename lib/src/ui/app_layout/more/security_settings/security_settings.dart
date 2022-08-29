import 'package:engagementwallet/src/ui/app_layout/more/security_settings/password_settings.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/src/widgets/forms/registration_form.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';

class SecuritySettings extends StatefulWidget {
  const SecuritySettings({Key? key}) : super(key: key);

  @override
  State<SecuritySettings> createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends State<SecuritySettings> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
   TextEditingController pinController = TextEditingController();
   TextEditingController newPinController = TextEditingController();
   TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: defaultVHPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => popView(context),
                child: Icon(
                  Icons.cancel,
                  color: greyColor,
                ),
              ),
              Text('Security Settings',
                  style: textStyleBig.copyWith(fontSize: 26)),
              Icon(
                Icons.cancel,
                color: whiteColor,
              )
            ],
          ),
        ),
        Divider(
          thickness: 0.8,
          height: 15,
          color: greyColor,
        ),
        // Padding(
        //   padding: defaultVHPadding,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.stretch,
        //     children: [
        //       ConstrainedBox(
        //         constraints: const BoxConstraints(maxWidth: 260),
        //         child: const Text(
        //           'Provide your active phone number. This would ensure identity verification.',
        //           textAlign: TextAlign.center,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        kNormalHeight,
        ArrowItems(
          mainText: 'Change Password',
          subText:
              'Change Password at any time',
          onTap: () {
            popView(context);
            openDialog(
                context,
                PasswordSettings(
                  passwordController: passwordController,
                  newPasswordController: newPasswordController,
                  confirmPasswordController: confirmPasswordController,
                ));
          },
        ),
        ArrowItems(
          mainText: 'Change Pin',
          subText:
              'Change Pin at any time',
          onTap: () {
            popView(context);
            openDialog(context,
                 PinSettings(
                 pinController: pinController,
                  newPinController: newPinController,
                  confirmController: newPasswordController,
                ));
          },
        ),
      ],
    );
  }
}

class ArrowItems extends StatelessWidget {
  const ArrowItems({
    Key? key,
    this.mainText,
    this.subText,
    this.onTap,
  }) : super(key: key);

  final String? mainText;
  final String? subText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: defaultHPadding,
          child: InkWell(
            onTap: onTap,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                        style: textStyle400Small.copyWith(color: darkGreyColor),
                      ),
                    )
                  ],
                ),
                Icon(Icons.chevron_right)
              ],
            ),
          ),
        ),
        SpaceDivider(
          height: 30,
        )
      ],
    );
  }
}
