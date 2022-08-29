import 'package:engagementwallet/src/logic/bloc/auth_bloc/form_validator_bloc/form_validator_bloc.dart';
import 'package:engagementwallet/src/logic/bloc/auth_bloc/validation_bloc.dart';
import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/ui/authentication/login/login.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/backgrounds/authentication_backgrounds.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/src/widgets/header_layout.dart';
import 'package:engagementwallet/src/widgets/textforms/phoneTextform.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final validator = ValidationBloc();

  TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    validator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthenticationBackGround(
      childPadding: defaultHPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderLayout(
            text: 'Login',
            onPressed: () => navigate(context, const LoginScreen()),
          ),
          kLargeHeight,
          Text(
            "Let's get started",
            style: textStyleBig.copyWith(fontSize: 26),
          ),
          kSmallHeight,
          Text('Provide your active phone number.', style: textStyle400Small),
          kNormalHeight,
          StreamBuilder<String>(
            stream: validator.phone,
            builder: (context, snapshot) {
              return PhoneTextForm(
                validatorCallback: formValidatorBloc.phoneValidator,
                onChangedCallback: validator.changePhone,
                controller: phoneController,
                textInputType: TextInputType.phone,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                labelText: 'Phone Number',
                useDefaultSuffix:
                    (phoneController.text.isNotEmpty && snapshot.error == null)
                        ? true
                        : false,
                text: 'Phone Number',
              );
            },
          )
        ],
      ),
      secondChild: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomButton(
              text: "VERIFY",
              loader: AuthMixin.auth(context, listen: true).isLoading,
              onPressed: () async {
                await AuthMixin.auth(context).startCustomerVerification(
                    phoneNumber: phoneController.text,
                    context: context,
                    verificationPurpose: 'Registration'

                );
              }),
        ],
      ),
    );
  }
}
