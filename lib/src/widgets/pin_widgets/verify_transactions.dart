import 'package:engagementwallet/src/logic/models/mock_data.dart';
import 'package:engagementwallet/src/ui/app_layout/app_layout.dart';
import 'package:engagementwallet/src/ui/authentication/signup/account_created.dart';
import 'package:engagementwallet/src/ui/authentication/signup/setup_complete.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/pin_widgets/pin_validation.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';

class VerifyTransactions extends StatefulWidget {
  const VerifyTransactions(
      {Key? key,
      this.bankName,
      this.bankNumber,
      this.accountName,
      this.amount,
      this.userId,
      this.type})
      : super(key: key);

  final String? bankName;
  final String? bankNumber;
  final String? accountName;
  final String? amount;
  final String? userId;
  final String? type;

  @override
  State<VerifyTransactions> createState() => _VerifyTransactionsState();
}

class _VerifyTransactionsState extends State<VerifyTransactions> {
  final TextEditingController _pinController = TextEditingController();

  String returnString(String name) {
    if (name == 'Bank Name') {
      return widget.bankName!;
    } else if (name == 'Account Number') {
      return widget.bankNumber!;
    } else if (name == 'Account Name') {
      return widget.accountName!;
    } else if (name == 'User Id') {
      return widget.userId!;
    } else if (name == 'Amount') {
      return widget.amount!;
    } else {
      return widget.amount!;
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
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
              Text('Verify Your Transactions',
                  style: textStyleBig.copyWith(fontSize: 22)),
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
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 260),
                child: const Text(
                  'Provide the appropriate information so as to verify your transactions.',
                  textAlign: TextAlign.center,
                ),
              ),
              kLargeHeight,
              Container(
                height: widget.type == 'transfer' ? 120 :220,
                child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        SpaceDivider(height: 30),
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.type == 'transfer'
                                ? bankTransfer[index]
                                : bankDetails[index],
                            style: textStyle400Small.copyWith(
                                color: darkGreyColor, fontSize: 16),
                          ),
                          Text(
                            returnString(widget.type == 'transfer'
                                ? bankTransfer[index]
                                : bankDetails[index]),
                            style: textStyle600Small,
                          )
                        ],
                      );
                    },
                    itemCount: widget.type == 'transfer'
                        ? bankTransfer.length
                        : bankDetails.length),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Enter Transaction Pin'),
                  kSmallHeight,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: PinValidation(
                      pinController: _pinController,
                      width: 59,
                      count: 4,
                    ),
                  ),
                ],
              ),
              kLargeHeight,
              CustomButton(
                text: "Verify",
                onPressed: () => navigate(
                    context,
                    AccountCreated(
                      onPressed: () => const AppLayout(),
                      mainText: 'Transaction Successful',
                      buttonText: 'MAKE ANOTHER PURCHASE',
                      showFab: true,
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
