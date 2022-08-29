import 'package:engagementwallet/src/logic/bloc/auth_bloc/form_validator_bloc/form_validator_bloc.dart';
import 'package:engagementwallet/src/logic/bloc/auth_bloc/validation_bloc.dart';
import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/ui/app_layout/app_layout.dart';
import 'package:engagementwallet/src/ui/authentication/forgot_password/forgot_password.dart';
import 'package:engagementwallet/src/ui/authentication/signup/signup.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/backgrounds/authentication_backgrounds.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/src/widgets/header_layout.dart';
import 'package:engagementwallet/src/widgets/textforms/editText.dart';
import 'package:engagementwallet/src/widgets/textforms/passwordTextform.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final validator = ValidationBloc();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    validator.dispose();
    emailController.dispose();
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
            text: 'Create Account',
            onPressed: () => navigate(context, const SignUpScreen()),
          ),
          kLargeHeight,
          Text(
            'Welcome',
            style: textStyle600Small.copyWith(fontSize: 30),
          ),
          // Image.asset(Assets.welcomeBack),
          kSmallHeight,
          Text('Provide your email and password.', style: textStyle400Small),
          kNormalHeight,
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
          kNormalHeight,
          PasswordSignUp(
            text: 'Password',
            validatorCallback: formValidatorBloc.passwordValidator,
            onChangedCallback: validator.changePassword,
            controller: passwordController,
            textInputType: TextInputType.visiblePassword,
            labelText: 'Password',
          ),
          kSmallHeight,
          InkWell(
            onTap: () => openDialog(
                context,
                const ForgotPassword(
                  type: 'forgot',
                )),
            child: Text('Forgot Password?', style: textStyleSecondary),
          )
        ],
      ),
      secondChild: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomButton(
              text: "LOGIN",
              loader: AuthMixin.auth(context, listen: true).isLoading,
              onPressed: () async {
                await AuthMixin.auth(context).loginUser(
                    emailController.text,
                    passwordController.text,
                    context
                );
              }),

          kSmallHeight,
          Center(
            child: SvgPicture.asset(Assets.faceId),
          ),
          kSmallHeight,
          Center(
            child: Text(
              'Tap to use biometric',
              style: textStyle14Small.copyWith(color: secondaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
