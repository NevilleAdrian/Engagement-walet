import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/forms/registration_form.dart';
import 'package:engagementwallet/src/widgets/pin_widgets/pin_validation.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';

class PasswordSettings extends StatefulWidget {
  const PasswordSettings(
      {Key? key,
      required this.passwordController,
      required this.newPasswordController,
      required this.confirmPasswordController})
      : super(key: key);

  final TextEditingController passwordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  @override
  State<PasswordSettings> createState() => _PasswordSettingsState();
}

class _PasswordSettingsState extends State<PasswordSettings> {
  @override
  void dispose() {
    widget.passwordController.dispose();
    widget.newPasswordController.dispose();
    super.dispose();
  }

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
              Text('Change Password',
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
        Padding(
          padding: defaultVHPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 260),
                child: const Text(
                  'Provide your active phone number. This would ensure identity verification.',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        kSmallHeight,
        Container(
          padding: defaultVHPadding,
          child: Column(
            children: [
              PasswordForm(
                passwordController: widget.passwordController,
                newPasswordController: widget.newPasswordController,
                confirmPasswordController: widget.confirmPasswordController,
              ),
              kNormalHeight,
              CustomButton(
                  text: "SAVE CHANGES",
                  loader: AuthMixin.auth(context, listen: true).isLoading,
                  onPressed: () => AuthMixin.auth(context).changePassword(
                      widget.confirmPasswordController.text,
                      widget.newPasswordController.text,
                      widget.passwordController.text,
                      context)),
            ],
          ),
        )
      ],
    );
  }
}

class PinSettings extends StatefulWidget {
  const PinSettings(
      {Key? key,
      required this.pinController,
      required this.newPinController,
      required this.confirmController})
      : super(key: key);
  final TextEditingController pinController;
  final TextEditingController newPinController;
  final TextEditingController confirmController;

  @override
  State<PinSettings> createState() => _PinSettingsState();
}

class _PinSettingsState extends State<PinSettings> {
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
              Text('Change Pin', style: textStyleBig.copyWith(fontSize: 26)),
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
        Padding(
          padding: defaultVHPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 260),
                child: const Text(
                  'Provide your active phone number. This would ensure identity verification.',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        kSmallHeight,
        Padding(
          padding: defaultVHPadding,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Current Pin'),
                  kSmallHeight,
                  PinValidation(
                    pinController: widget.pinController,
                    count: 4,
                  ),
                ],
              ),
              kSmallHeight,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('New Pin'),
                  kSmallHeight,
                  PinValidation(
                    pinController: widget.newPinController,
                    count: 4,
                  ),
                ],
              ),
              kSmallHeight,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Re-enter New Pin'),
                  kSmallHeight,
                  PinValidation(
                    pinController: widget.confirmController,
                    count: 4,
                  ),
                ],
              ),
              kNormalHeight,
              CustomButton(
                  text: "SAVE CHANGES", onPressed: () => popView(context)),
            ],
          ),
        )
      ],
    );
  }
}
