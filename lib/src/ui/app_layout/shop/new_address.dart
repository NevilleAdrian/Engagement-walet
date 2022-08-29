
import 'package:engagementwallet/src/logic/bloc/auth_bloc/form_validator_bloc/form_validator_bloc.dart';
import 'package:engagementwallet/src/logic/bloc/auth_bloc/validation_bloc.dart';
import 'package:engagementwallet/src/logic/mixin/cart_mixin/cart_mixin.dart';
import 'package:engagementwallet/src/ui/authentication/forgot_password/change_password.dart';
import 'package:engagementwallet/src/ui/authentication/signup/account_created.dart';
import 'package:engagementwallet/src/ui/authentication/signup/complete_profile.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/src/widgets/pin_widgets/pin_validation.dart';
import 'package:engagementwallet/src/widgets/textforms/editText.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';

class NewAddress extends StatefulWidget {
  const NewAddress({Key? key}) : super(key: key);


  @override
  State<NewAddress> createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {
  final validator = ValidationBloc();
  TextEditingController addressCC = TextEditingController();
  @override
  void dispose() {
    validator.dispose();
    addressCC.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    CartMixin cart = CartMixin.cartProvider(context, listen: true);

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
              Text('Add New Address',
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
              //   constraints: const BoxConstraints(maxWidth: 200),
              //   child: const Text(
              //     'Provide your active phone number. This would ensure identity verification.',
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              kSmallHeight,
              Column(
                children: [
                  EditTextSignUp(
                    text: 'Address',
                    controller: addressCC,
                    textInputType: TextInputType.text,
                    validatorCallback: formValidatorBloc.addressValidator,
                    onChangedCallback: validator.changeAddressOnly,
                    labelText: "Placeholder Address",
                  ),
                ],
              ),
              kVeryLargeHeight,
              CustomButton(
                text: "SAVE AND CONTINUE",
                onPressed: () {
                  cart.setNewAddressList({"address": addressCC.text});
                  popView(context);
                }
              ),

            ],
          ),
        )
      ],
    );
  }
}
