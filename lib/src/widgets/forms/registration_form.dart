import 'dart:io';

import 'package:engagementwallet/src/logic/bloc/auth_bloc/form_validator_bloc/form_validator_bloc.dart';
import 'package:engagementwallet/src/logic/bloc/auth_bloc/validation_bloc.dart';
import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/image_display.dart';
import 'package:engagementwallet/src/widgets/textforms/editText.dart';
import 'package:engagementwallet/src/widgets/textforms/passwordTextform.dart';
import 'package:engagementwallet/src/widgets/textforms/phoneTextform.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm(
      {Key? key,
      required this.firstNameController,
      required this.lastNameController,
      required this.emailController,
      this.phoneController})
      : super(key: key);

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  // final TextEditingController userNameController;
  final TextEditingController emailController;
  final TextEditingController? phoneController;

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final validator = ValidationBloc();
  String imageBytes = '';
  File? _imageFile;

  @override
  void dispose() {
    validator.dispose();
    widget.emailController.dispose();
    widget.firstNameController.dispose();
    widget.lastNameController.dispose();
    // widget.userNameController.dispose();
    widget.phoneController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () async {
            File image =
                await picker.onImagePickerPressed(ImageSource.gallery, context);
            setState(() {
              _imageFile = image;
              picker.setCroppedImage(image);
            });
            // Uint8List imagebytes = await _imageFile!.readAsBytes(); //convert to bytes
            // String base64string = base64Encode(imagebytes);
            // imageBytes = base64string;
            AuthMixin.auth(context).setImage(image);
          },
          child: Row(
            children: [
              picker.imageDisplay(Image.asset(Assets.profilePic)),
              kSmallWidth,
              Text('Tap to change profile picture', style: textStyle400Small)
            ],
          ),
        ),
        kSmallHeight,
        EditTextSignUp(
          text: 'First Name',
          validatorCallback: formValidatorBloc.firstNameValidator,
          onChangedCallback: validator.changeFirstName,
          controller: widget.firstNameController,
          textInputType: TextInputType.text,
          labelText: "First Name",
        ),
        kSmallHeight,
        EditTextSignUp(
          text: 'Last Name',
          validatorCallback: formValidatorBloc.firstNameValidator,
          onChangedCallback: validator.changeLastName,
          controller: widget.lastNameController,
          textInputType: TextInputType.text,
          labelText: "Last Name",
        ),
        // kSmallHeight,
        // StreamBuilder<String>(
        //     stream: validator.userName,
        //     builder: (context, snapshot) {
        //       return EditTextSignUp(
        //         text: 'User Name',
        //         validatorCallback: formValidatorBloc.userNameValidator,
        //         onChangedCallback: validator.changeUserName,
        //         controller: widget.userNameController,
        //         textInputType: TextInputType.text,
        //         labelText: "User Name",
        //         useDefaultSuffix: (widget.userNameController.text.isNotEmpty &&
        //             snapshot.error == null)
        //             ? true
        //             : false,
        //       );
        //     }),
        kSmallHeight,
        StreamBuilder<String>(
            stream: validator.emailOnly,
            builder: (context, snapshot) {
              return EditTextSignUp(
                text: 'Email Address',
                validatorCallback: formValidatorBloc.emailValidator,
                onChangedCallback: validator.changeEmailOnly,
                controller: widget.emailController,
                textInputType: TextInputType.emailAddress,
                labelText: "Email",
                useDefaultSuffix: (widget.emailController.text.isNotEmpty &&
                        snapshot.error == null)
                    ? true
                    : false,
              );
            }),
        kNormalHeight,
        if (widget.phoneController != null)
          Column(
            children: [
              StreamBuilder<String>(
                stream: validator.phone,
                builder: (context, snapshot) {
                  return PhoneTextForm(
                    validatorCallback: formValidatorBloc.phoneValidator,
                    onChangedCallback: validator.changePhone,
                    controller: widget.phoneController,
                    textInputType: TextInputType.phone,
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    labelText: 'Phone Number',
                    useDefaultSuffix:
                        (widget.phoneController!.text.isNotEmpty &&
                                snapshot.error == null)
                            ? true
                            : false,
                    text: 'Phone Number',
                  );
                },
              ),
              kNormalHeight,
            ],
          )
      ],
    );
  }
}

class PasswordForm extends StatefulWidget {
  const PasswordForm(
      {Key? key,
      required this.passwordController,
      required this.newPasswordController,
      required this.confirmPasswordController})
      : super(key: key);

  final TextEditingController passwordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final validator = ValidationBloc();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PasswordSignUp(
          text: 'Current Password',
          validatorCallback: formValidatorBloc.passwordValidator,
          onChangedCallback: validator.changePassword,
          controller: widget.passwordController,
          textInputType: TextInputType.visiblePassword,
          labelText: 'Password',
        ),
        kSmallHeight,
        PasswordSignUp(
          text: 'Create New Password',
          validatorCallback: formValidatorBloc.passwordValidator,
          onChangedCallback: validator.changePassword,
          controller: widget.newPasswordController,
          textInputType: TextInputType.visiblePassword,
          labelText: 'Password',
        ),
        kSmallHeight,
        PasswordSignUp(
          text: 'Confirm Password',
          validatorCallback: formValidatorBloc.passwordValidator,
          onChangedCallback: validator.changePassword,
          controller: widget.confirmPasswordController,
          textInputType: TextInputType.visiblePassword,
          labelText: 'Password',
        ),
      ],
    );
  }
}
