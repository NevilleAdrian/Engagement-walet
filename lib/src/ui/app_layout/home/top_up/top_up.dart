import 'package:engagementwallet/src/ui/app_layout/home/bank_transfer/bank_transfer.dart';
import 'package:engagementwallet/src/ui/app_layout/home/card_transfer/card_transfer.dart';
import 'package:engagementwallet/src/ui/authentication/forgot_password/change_password.dart';
import 'package:engagementwallet/src/ui/authentication/signup/account_created.dart';
import 'package:engagementwallet/src/ui/authentication/signup/complete_profile.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/src/widgets/dialogs/transaction_dialog.dart';
import 'package:engagementwallet/src/widgets/pin_widgets/pin_validation.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopUp extends StatefulWidget {
  const TopUp({Key? key}) : super(key: key);
  @override
  State<TopUp> createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  TransactionDialog(
      mainText: 'Top-up Balance',
      firstIcon: Assets.bank,
      subText: 'Top up your balance with either bank transfer, card or bank account',
      firstItemText: 'Bank Transfer',
      secondIcon: Assets.card,
      secondItemText: 'Card or Bank Account',
      firstItemTap: () => navigate(context, const BankTransfer()),
      secondItemTap: () => navigate(context, const CardTransfer()),
    );
  }
}


