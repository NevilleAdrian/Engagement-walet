import 'package:engagementwallet/src/logic/bloc/auth_bloc/form_validator_bloc/form_validator_bloc.dart';
import 'package:engagementwallet/src/logic/bloc/auth_bloc/validation_bloc.dart';
import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/textforms/editText.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key, this.type}) : super(key: key);

  final String? type;

  @override
  State<ForgotPassword> createState() => _ForgotState();
}

class _ForgotState extends State<ForgotPassword> {
  final validator = ValidationBloc();

  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    validator.dispose();
    emailController.dispose();
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
              Text('Forgot Password',
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
              //CHANGE TO DEFAULT MESSAGE
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 260),
                child: const Text(
                  'Provide your active email. This would ensure Identity Verification',
                  textAlign: TextAlign.center,
                ),
              ),
              kVeryLargeHeight,
              StreamBuilder<String>(
                  stream: validator.emailOnly,
                  builder: (context, snapshot) {
                    return EditTextSignUp(
                      text: 'Email Address',
                      validatorCallback: formValidatorBloc.emailValidator,
                      onChangedCallback: validator.changeEmailOnly,
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      labelText: "Email",
                      useDefaultSuffix: (emailController.text.isNotEmpty &&
                              snapshot.error == null)
                          ? true
                          : false,
                    );
                  }),
              kVeryLargeHeight,

              CustomButton(
                text: "PROCEED",
                loader: AuthMixin.auth(context, listen: true).isLoading,
                onPressed: () async => await AuthMixin.auth(context)
                    .forgotPassword(
                        emailController.text, widget.type!, context),
              ),
            ],
          ),
        )
      ],
    );
  }
}
