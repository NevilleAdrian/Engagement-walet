import 'package:engagementwallet/src/logic/bloc/auth_bloc/form_validator_bloc/form_validator_bloc.dart';
import 'package:engagementwallet/src/logic/bloc/auth_bloc/validation_bloc.dart';
import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/textforms/passwordTextform.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ForgotState();
}

class _ForgotState extends State<ChangePassword> {
  final validator = ValidationBloc();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    validator.dispose();
    passwordController.dispose();
    confirmController.dispose();
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
              kVeryLargeHeight,
              PasswordSignUp(
                text: 'Create New Password',
                validatorCallback: formValidatorBloc.passwordValidator,
                onChangedCallback: validator.changePassword,
                controller: passwordController,
                textInputType: TextInputType.visiblePassword,
                labelText: 'Password',
              ),
              kVeryLargeHeight,
              PasswordSignUp(
                text: 'Confirm New Password',
                validatorCallback: formValidatorBloc.passwordValidator,
                onChangedCallback: validator.changePassword,
                controller: confirmController,
                textInputType: TextInputType.visiblePassword,
                labelText: 'Confirm Password',
              ),
              CustomButton(
                text: "CHANGE PASSWORD",
                onPressed: () async => await AuthMixin.auth(context)
                    .resetPassword(passwordController.text,
                        confirmController.text, context),
              ),
            ],
          ),
        )
      ],
    );
  }
}
