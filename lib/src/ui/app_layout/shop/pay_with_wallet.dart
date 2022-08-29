
import 'package:engagementwallet/src/logic/mixin/cart_mixin/cart_mixin.dart';
import 'package:engagementwallet/src/ui/app_layout/app_layout.dart';
import 'package:engagementwallet/src/ui/app_layout/home/top_up/top_up.dart';
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

class PayWithWallet extends StatefulWidget {
  const PayWithWallet({Key? key}) : super(key: key);

  @override
  State<PayWithWallet> createState() => _PayWithWalletState();
}

class _PayWithWalletState extends State<PayWithWallet> {


  @override
  Widget build(BuildContext context) {
    return AuthenticationBackGround(
        padding: EdgeInsets.zero,
        height: 2.3.h,
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
                    'Wallet Purchase',
                    style: textStyleBig.copyWith(fontSize: 26),
                  ),
                  kSmallHeight,
                  Text(
                    'Make payment with your wallet',
                    style: textStyle400Small,
                  ),
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

          ],
        ),
        secondChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Amount', style: TextStyle(color: darkGreyColor),),

                Text('₦200,000', style: textStyle400Small,),
              ],
            ),
            SpaceDivider(
             height: 50,
            ),

            CustomButton(
              text: "CONTINUE",
              loader: CartMixin.cartProvider(context, listen: true).isLoading,
              onPressed: () => CartMixin.cartProvider(context).checkOut(context, 1)
            ),
          ],
        ));
  }
}

