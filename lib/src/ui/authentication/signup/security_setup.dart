import 'package:engagementwallet/src/logic/bloc/auth_bloc/form_validator_bloc/form_validator_bloc.dart';
import 'package:engagementwallet/src/logic/bloc/auth_bloc/validation_bloc.dart';
import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/backgrounds/authentication_backgrounds.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/src/widgets/pin_widgets/create_pin.dart';
import 'package:engagementwallet/src/widgets/textforms/passwordTextform.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SecuritySetup extends StatefulWidget {
  const SecuritySetup(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.emailAddress, this.image})
      : super(key: key);

  final String firstName;
  final String lastName;
  final String emailAddress;
  final String? image;

  @override
  State<SecuritySetup> createState() => _SecuritySetupState();
}

class _SecuritySetupState extends State<SecuritySetup> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  //validation boolean
  bool autoValidate = false;
  final validator = ValidationBloc();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    validator.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthenticationBackGround(
      height: 1.5,
      padding: EdgeInsets.zero,
      childPadding: defaultHPadding,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(Assets.lock),
          ),
          Padding(
            padding: defaultVHPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Security Setup',
                  style: textStyleBig.copyWith(fontSize: 26),
                ),
                kSmallHeight,
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 220),
                  child: Text(
                    'Create password, to protect your account.',
                    style: textStyle400Small,
                  ),
                ),
                kVeryLargeHeight,
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        PasswordSignUp(
                          text: 'Create A Password',
                          validatorCallback:
                              formValidatorBloc.passwordValidator,
                          onChangedCallback: validator.changePassword,
                          controller: passwordController,
                          textInputType: TextInputType.visiblePassword,
                          labelText: 'Password',
                        ),
                        kNormalHeight,
                        PasswordSignUp(
                          text: 'Confirm Password',
                          validatorCallback:
                              formValidatorBloc.passwordValidator,
                          onChangedCallback: validator.changePassword,
                          controller: confirmController,
                          textInputType: TextInputType.visiblePassword,
                          labelText: 'Confirm Password',
                        ),
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
      secondChild: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomButton(
                text: "CONTINUE",
                loader: AuthMixin.auth(context, listen: true).isLoading,
                onPressed: () async {
                  final FormState form = formKey.currentState!;
                  if (!form.validate()) {
                    autoValidate = true; // Start validating on every change.
                  } else {
                    print('hi');
                    await AuthMixin.auth(context).updateCustomerProfile(
                        email: widget.emailAddress,
                        password: passwordController.text,
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                        image: AuthMixin.auth(context).image ?? '',
                        context: context);
                  }
                }),

          ],
        ),
      ),
    );
  }
}
