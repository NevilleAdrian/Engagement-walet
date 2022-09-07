import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/pin_widgets/pin_validation.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';

class VerifyPin extends StatefulWidget {
  const VerifyPin({Key? key, this.type}) : super(key: key);

  final String? type;

  @override
  State<VerifyPin> createState() => _VerifyPinState();
}

class _VerifyPinState extends State<VerifyPin> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    print("type: ${widget.type}");
    _pinController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    print(widget.type);
    super.initState();
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
              Text('Verify Your Number',
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
                  'Enter the 6-digit PIN sent to your email',
                  textAlign: TextAlign.center,
                ),
              ),
              kLargeHeight,
              PinValidation(
                pinController: _pinController,
              ),
              kLargeHeight,
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Didn’t receive any code? \n",
                    style: textStyle14Small,
                    children: [
                      TextSpan(
                          text: "Resend OTP",
                          style: textStyle14Small.copyWith(color: Colors.red)),
                    ]),
              ),
              kVeryLargeHeight,
              CustomButton(
                  text: "PROCEED",
                  loader: AuthMixin.auth(context, listen: true).isLoading,
                  onPressed: () async {
                    if (widget.type != 'forgot') {
                      await AuthMixin.auth(context).verifyCustomerOtp(
                          otp: _pinController.text,
                          context: context,
                          type: widget.type,
                          verificationPurpose: 'Registration');
                    } else {
                      await AuthMixin.auth(context).verifyCustomerOtp(
                          otp: _pinController.text,
                          context: context,
                          type: widget.type,
                          verificationPurpose: 'PasswordReset');
                    }
                  }),
              kNormalHeight,
              InkWell(
                onTap: () => popView(context),
                child: Text(
                  'Change ${widget.type == 'phone' ? 'Phone Number' : 'Email'}',
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
