
import 'package:engagementwallet/src/logic/bloc/auth_bloc/form_validator_bloc/form_validator_bloc.dart';
import 'package:engagementwallet/src/logic/bloc/auth_bloc/validation_bloc.dart';
import 'package:engagementwallet/src/logic/models/mock_data.dart';
import 'package:engagementwallet/src/ui/app_layout/home/top_up/top_up.dart';
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

class WithdrawBalance extends StatefulWidget {
  const WithdrawBalance({Key? key}) : super(key: key);

  @override
  State<WithdrawBalance> createState() => _WithdrawBalanceState();
}

class _WithdrawBalanceState extends State<WithdrawBalance> {
  final validator = ValidationBloc();
  TextEditingController bankNameCC = TextEditingController();
  TextEditingController accountNumberCC = TextEditingController();
  TextEditingController amountCC = TextEditingController();

  String bankCode = '';

  @override
  void dispose() {
    validator.dispose();
    bankNameCC.dispose();
    accountNumberCC.dispose();
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
                    'Withdraw Balance',
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
                        color: orangeColor),
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
                    text: 'Bank Account',
                    controller: bankNameCC,
                    textInputType: TextInputType.text,
                    suffix: Icon(
                      Icons.keyboard_arrow_down,
                      color: darkPrimaryColor,
                    ),
                    readOnly: true,
                    labelText: "Please Select",
                    onTap: () => openDialog(
                        context,
                        BankListModal(
                            List.generate(
                                bankResponse.length,
                                (index) =>
                                    bankResponse.elementAt(index).bankName!),
                            (index, value) {
                          setState(() {
                            bankNameCC.text = value;
                            bankCode = bankResponse
                                .firstWhere(
                                    (element) => element.bankName == value)
                                .bankCode!;
                          });
                        }),
                        1.6),
                  ),
                  kVerySmallHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Choose Saved Accounts',
                        style: textStyleSecondary.copyWith(fontSize: 14),
                      )
                    ],
                  ),
                  kSmallHeight,
                  EditTextSignUp(
                    text: 'Account Number',
                    controller: accountNumberCC,
                    textInputType: TextInputType.number,
                    validatorCallback: formValidatorBloc.accNoValidator,
                    onChangedCallback: validator.changeAccNo,
                    labelText: "Account Number",
                  ),
                  kSmallHeight,
                  EditTextSignUp(
                    text: 'Amount to Send',
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
              onPressed: () => openDialog(context,  VerifyTransactions(
                amount: '₦${amountCC.text}',
                accountName: 'Neville Chukumah',
                bankName: bankNameCC.text,
                bankNumber: accountNumberCC.text,
              )),
            ),
            kSmallHeight,
          ],
        ));
  }
}

