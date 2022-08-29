
import 'package:engagementwallet/src/logic/bloc/auth_bloc/form_validator_bloc/form_validator_bloc.dart';
import 'package:engagementwallet/src/logic/bloc/auth_bloc/validation_bloc.dart';
import 'package:engagementwallet/src/ui/app_layout/home/top_up/top_up.dart';
import 'package:engagementwallet/src/ui/app_layout/home/transfer/friend_list.dart';
import 'package:engagementwallet/src/ui/app_layout/home/withdraw/banklist_modal.dart';
import 'package:engagementwallet/src/utils/colors.dart';
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

class MakeTransfer extends StatefulWidget {
  const MakeTransfer({Key? key}) : super(key: key);

  @override
  State<MakeTransfer> createState() => _MakeTransferState();
}

class _MakeTransferState extends State<MakeTransfer> {
  final validator = ValidationBloc();
  TextEditingController userNameController = TextEditingController();
  TextEditingController amountCC = TextEditingController();

  @override
  void dispose() {
    validator.dispose();
    userNameController.dispose();
    amountCC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthenticationBackGround(
        padding: EdgeInsets.zero,
        height: 1.2.h,
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
                    'Single Recipient Transfer',
                    style: textStyleBig.copyWith(fontSize: 26),
                  ),
                  // kSmallHeight,
                  // Text(
                  //   'Provide your active phone number. This would ensure identity verification.',
                  //   style: textStyle400Small,
                  // ),
                  kSmallHeight,
                  Container(
                    padding: defaultVHBIGPadding,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: darkPrimaryColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Available Balance',
                              style: textStyleSmallWhite.copyWith(fontSize: 14),
                            ),
                            kVerySmallHeight,
                            Text(
                              '₦345,000',
                              style: textStyleBigWhite.copyWith(fontSize: 28),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () => openDialog(context, const TopUp()),
                            child: const CirclePlus())
                      ],
                    ),
                  ),
                  kVerySmallHeight,
                ],
              ),
            ),
            const SpaceDivider(),
            Padding(
              padding: defaultHPadding,
              child: Column(
                children: [
                  EditTextSignUp(
                    text: 'Amount to Send',
                    controller: amountCC,
                    textInputType: TextInputType.number,
                    validatorCallback: formValidatorBloc.accNoValidator,
                    onChangedCallback: validator.changeAccNo,
                    labelText: "₦0.00",
                  ),
                  kSmallHeight,
                  StreamBuilder<String>(
                      stream: validator.userName,
                      builder: (context, snapshot) {
                        return EditTextSignUp(
                          text: 'User Name',
                          validatorCallback:
                              formValidatorBloc.userNameValidator,
                          onChangedCallback: validator.changeUserName,
                          controller: userNameController,
                          textInputType: TextInputType.text,
                          labelText: "@placeholder",
                          useDefaultSuffix:
                              (userNameController.text.isNotEmpty &&
                                      snapshot.error == null)
                                  ? true
                                  : false,
                        );
                      }),
                  kSmallHeight,
                  InkWell(
                    onTap: () => openDialog(context, const FriendList()),
                    child: Center(
                      child: Text('Select from friend list', style: textStyleSecondary,),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        secondChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomButton(
                text: "CONTINUE", onPressed: () => openDialog(context, VerifyTransactions(userId: userNameController.text, amount: amountCC.text, type: 'transfer',))),
            kSmallHeight,
          ],
        ));
  }
}
