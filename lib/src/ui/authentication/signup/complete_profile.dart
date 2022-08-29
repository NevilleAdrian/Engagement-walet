import 'package:engagementwallet/src/ui/authentication/signup/security_setup.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/backgrounds/authentication_backgrounds.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/forms/registration_form.dart';
import 'package:engagementwallet/src/widgets/image_display.dart';
import 'package:engagementwallet/src/widgets/textforms/editText.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  bool autoValidate = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthenticationBackGround(
      height: 1.26,
      padding: defaultHPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Complete Your Profile',
            style: textStyleBig.copyWith(fontSize: 26),
          ),
          // kSmallHeight,
          // Text('Provide your correct information. This would ensure identity verification.', style: textStyle400Small,),
          kNormalHeight,

          Form(
              key: formKey,
              child: RegistrationForm(
                firstNameController: firstNameController,
                lastNameController: lastNameController,
                emailController: emailController,
                // userNameController: userNameController,
              ))
        ],
      ),
      secondChild: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomButton(
              text: "CONTINUE",
              loader: false,
              onPressed: () async {
                final FormState form = formKey.currentState!;
                if (!form.validate()) {
                  autoValidate = true; // Start validating on every change.
                } else {
                  navigate(
                    context,
                    SecuritySetup(
                      firstName: firstNameController.text,
                      emailAddress: emailController.text,
                      lastName: lastNameController.text,
                    ),
                  );
                }


              },
            ),
            kNormalHeight,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "By clicking Continue, you agree to our\n \n",
                  style: textStyle14Small,
                  children: [
                    TextSpan(
                        text: "Terms of Service ",
                        style:
                            textStyle14Small.copyWith(color: secondaryColor)),
                    TextSpan(text: "and", style: textStyle14Small),
                    TextSpan(
                        text: " Privacy Policy.",
                        style:
                            textStyle14Small.copyWith(color: secondaryColor)),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
