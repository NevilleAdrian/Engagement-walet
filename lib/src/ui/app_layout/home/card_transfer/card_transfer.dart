
import 'package:engagementwallet/src/logic/bloc/auth_bloc/form_validator_bloc/form_validator_bloc.dart';
import 'package:engagementwallet/src/logic/bloc/auth_bloc/validation_bloc.dart';
import 'package:engagementwallet/src/logic/mixin/cart_mixin/cart_mixin.dart';
import 'package:engagementwallet/src/ui/app_layout/app_layout.dart';
import 'package:engagementwallet/src/ui/app_layout/home/withdraw/banklist_modal.dart';
import 'package:engagementwallet/src/ui/authentication/signup/account_created.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/back_arrow.dart';
import 'package:engagementwallet/src/widgets/backgrounds/authentication_backgrounds.dart';
import 'package:engagementwallet/src/widgets/circle_plus.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/src/widgets/pin_widgets/verify_transactions.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/src/widgets/textforms/editText.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardTransfer extends StatefulWidget {
  const CardTransfer({Key? key}) : super(key: key);

  @override
  State<CardTransfer> createState() => _CardTransferState();
}

class _CardTransferState extends State<CardTransfer> {
  final validator = ValidationBloc();
  TextEditingController amountCC = TextEditingController();

  String bankCode = '';

  @override
  void dispose() {
    validator.dispose();
    amountCC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthenticationBackGround(
        padding: EdgeInsets.zero,
        height: 2.h,
        childPadding: defaultHPadding,

        child: Column(
          children: [
            Padding(
              padding: defaultHPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const BackArrow(),
                  kSmallHeight,
                  Text(
                    'Card or Bank Account',
                    style: textStyleBig.copyWith(fontSize: 26),
                  ),
                  kSmallHeight,
                  Text(
                    'Top-up your wallet with Card',
                    style: textStyle400Small,
                  ),

                ],
              ),

            ),
            kSmallHeight,
            Padding(
              padding: defaultHPadding,
              child: Column(
                children: [
                  EditTextSignUp(
                    text: 'Top-up Amount',
                    controller: amountCC,
                    textInputType: TextInputType.number,
                    validatorCallback: formValidatorBloc.accNoValidator,
                    onChangedCallback: validator.changeAccNo,
                    labelText: "₦0.00",
                  ),
                ],
              ),
            )
          ],
        ),
        secondChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomButton(
              text: "CONTINUE",
              loader: CartMixin.cartProvider(context, listen: true).isLoading,
              onPressed: () => CartMixin.cartProvider(context).checkOut(context, 2),
            ),
            kSmallHeight,
          ],
        ));
  }
}

