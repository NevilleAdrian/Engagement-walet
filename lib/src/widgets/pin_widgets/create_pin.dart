import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/ui/authentication/signup/account_created.dart';
import 'package:engagementwallet/src/ui/authentication/signup/setup_complete.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/pin_widgets/pin_validation.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';

class CreatePin extends StatefulWidget {
  const CreatePin({Key? key}) : super(key: key);

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _confirmPinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    _confirmPinController.dispose();
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
              Text('Setup Transaction PIN',
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
              // ConstrainedBox(
              //   constraints: const BoxConstraints(maxWidth: 260),
              //   child: const Text(
              //     'Provide your active phone number. This would ensure identity verification.',
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              // kLargeHeight,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Create Pin'),
                  kSmallHeight,
                  PinValidation(
                    pinController: _pinController,
                    width: 70,
                    count: 4,
                  ),
                ],
              ),
              kLargeHeight,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Re-enter Pin'),
                  kSmallHeight,
                  PinValidation(
                    pinController: _confirmPinController,
                    width: 70,
                    count: 4,
                  ),
                ],
              ),
              kLargeHeight,
              CustomButton(
                  text: "CREATE PIN",
                  loader: AuthMixin.auth(context, listen: true).isLoading,
                  onPressed: () async {
                    if (_pinController.text != _confirmPinController.text) {
                      showFlush(context, "Pin doesn't match");
                    } else {
                      print('hi');
                      await AuthMixin.auth(context).setPin(
                          pin:_confirmPinController.text,
                          context: context);
                    }
                  }),

              kNormalHeight,
              InkWell(
                onTap: () => navigate(context, const SetupComplete()),
                child: Text(
                  'Skip This',
                  style: textStyleSecondary,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
