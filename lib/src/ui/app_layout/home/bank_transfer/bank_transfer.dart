
import 'package:engagementwallet/src/logic/bloc/auth_bloc/validation_bloc.dart';
import 'package:engagementwallet/src/ui/app_layout/app_layout.dart';
import 'package:engagementwallet/src/ui/app_layout/home/withdraw/banklist_modal.dart';
import 'package:engagementwallet/src/ui/authentication/signup/account_created.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/functions.dart';
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

class BankTransfer extends StatefulWidget {
  const BankTransfer({Key? key}) : super(key: key);

  @override
  State<BankTransfer> createState() => _BankTransferState();
}

class _BankTransferState extends State<BankTransfer> {
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
        height: 1.5.h,
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
                    'Bank Transfer',
                    style: textStyleBig.copyWith(fontSize: 26),
                  ),
                  kSmallHeight,
                  Text(
                    'Copy Account details, make payments with your financial institution, and confirm your transactions',
                    style: textStyle400Small,
                  ),
                  kSmallHeight,
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: primaryColor
                      ),
                      color: otherColor,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: defaultVHPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Bank Name', style: textStyle14Small.copyWith(color: darkGreyColor),),
                              Text('Mayfield Bank', style: textStyle400Small,),
                            ],
                          ),
                        ),
                        kSmallHeight,
                        SpaceDivider(height: 0,),
                        Padding(
                          padding: defaultVHPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Account Number', style: textStyle14Small.copyWith(color: darkGreyColor),),
                              Text('0043657894', style: textStyle400Small,),
                            ],
                          ),
                        ),


                        kSmallHeight,

                      ],
                    ),
                  ),
                  kSmallHeight,

                  InkWell(
                    onTap: () => copy('figma.com/file/iV6xtqGzqEf6uf5lloe...'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.copy_sharp, color: secondaryColor),
                        kVerySmallWidth,
                        Text(
                          'Copy Account Number',
                          style: textStyleSecondary,
                        )
                      ],
                    ),
                  ),


                ],
              ),
            ),
            SpaceDivider(),
            Padding(
              padding: defaultHPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:  [
                  Text('1. Copy account number', style: textStyle400Small.copyWith(color: darkGreenColor)),
                  kVerySmallHeight,
                  Text('2. Transfer amount to top-up with', style: textStyle400Small.copyWith(color: darkGreenColor)),
                  kVerySmallHeight,

                  Text('3. Transaction is verified, and wallet funded', style: textStyle400Small.copyWith(color: darkGreenColor)),
                ],
              ),
            )


          ],
        ),
        secondChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomButton(
              text: "CONFIRM MY TRANSACTION",
              onPressed: () => navigate(
                  context,
                  AccountCreated(
                    onPressed: () => const AppLayout(),
                    mainText: 'Transaction Successful',
                    buttonText: 'MAKE ANOTHER PURCHASE',
                    showFab: true,
                  )),
            ),
            kSmallHeight,
          ],
        ));
  }
}

