import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/forms/registration_form.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AuthMixin auth = AuthMixin.auth(context, listen: true);

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
              Text('Profile Settings',
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
        Container(
          padding: defaultVHPadding,
          child: Column(
            children: [
              RegistrationForm(
                firstNameController: firstNameController,
                lastNameController: lastNameController,
                // userNameController: userNameController,
                emailController: emailController,
                phoneController: phoneController,
              ),
              CustomButton(
                  text: "SAVE CHANGES",
                  loader: AuthMixin.auth(context, listen: true).isLoading,
                  onPressed: () async {
                    print('hi');
                    await AuthMixin.auth(context).updateCustomerProfile(
                        emailController.text == null
                            ? auth.user.email!
                            : emailController.text,
                        '',
                        firstNameController.text == null
                            ? auth.user.firstName!
                            : firstNameController.text,
                        lastNameController.text == null
                            ? auth.user.lastName!
                            : lastNameController.text,
                        auth.user.phoneNumber!,
                        AuthMixin.auth(context).image!,
                        true,
                        context);
                  }),
              // CustomButton(
              //     text: "SAVE CHANGES", onPressed: () => popView(context)),
            ],
          ),
        )
      ],
    );
  }
}
