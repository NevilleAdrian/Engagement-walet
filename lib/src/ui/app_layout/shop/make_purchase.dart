import 'package:carousel_slider/carousel_slider.dart';
import 'package:engagementwallet/src/logic/mixin/cart_mixin/cart_mixin.dart';
import 'package:engagementwallet/src/ui/app_layout/app_layout.dart';
import 'package:engagementwallet/src/ui/app_layout/home/bank_transfer/bank_transfer.dart';
import 'package:engagementwallet/src/ui/app_layout/home/card_transfer/card_transfer.dart';
import 'package:engagementwallet/src/ui/app_layout/home/top_up/top_up.dart';
import 'package:engagementwallet/src/ui/app_layout/home/withdraw/withdraw_balance.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/add_to_cart.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/new_address.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/pay_with_wallet.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/back_arrow.dart';
import 'package:engagementwallet/src/widgets/backgrounds/authentication_backgrounds.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/src/widgets/dialogs/transaction_dialog.dart';
import 'package:engagementwallet/src/widgets/sliders/vertical_sliders.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/src/widgets/textforms/editText.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../values/text_styles.dart';
import '../../authentication/signup/account_created.dart';

class MakePurchase extends StatefulWidget {
  const MakePurchase(
      {Key? key,
        })
      : super(key: key);



  @override
  State<MakePurchase> createState() => _MakePurchaseState();
}

class _MakePurchaseState extends State<MakePurchase> {
  late List<String> imageList;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartMixin cart = CartMixin.cartProvider(context);
    return AuthenticationBackGround(
        height: 1.7.h,
        padding: EdgeInsets.zero,
        childPadding: defaultVHPadding.copyWith(bottom: 40),
        child: SingleChildScrollView(
          child: Container(
            color:  whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Padding(
                  padding: defaultLeftPadding,
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BackArrow(
                              onTap: (){
                                popView(context);
                              },
                            ),
                            kSmallHeight,
                            Text('Make Store Purchase',
                                style: textStyleBig.copyWith(fontSize: 26)),
                            kSmallHeight,
                            Text('Make Payments either via our payment provider or directly to the store ',
                                style: textStyle400Small),
                            kNormalHeight,
                          ],
                        ),
                      ),
                      SvgPicture.asset(Assets.eCommerce)
                    ],
                  ),
                ),
                kSmallHeight,
                Padding(
                  padding: defaultHPadding,

                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Saved Address',
                            style: textStyle400Small,
                          ),
                          InkWell(
                              onTap: () =>
                                  openDialog(context, const NewAddress()),
                              child: Text(
                                '+ Add New Address',
                                style:
                                textStyleSecondary.copyWith(fontSize: 14),
                              )),
                        ],
                      ),
                      kSmallHeight,
                      Container(
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: secondaryColor),
                          color: otherColor,
                        ),
                        child: ListView.separated(
                          itemCount: cart.addressList.length,
                          separatorBuilder: (context, index) => const SpaceDivider(
                            height: 20,
                          ),
                          itemBuilder: (context, index) {
                            String? address =
                            cart.addressList[index]['address'];
                            return Padding(
                              padding: defaultHPadding.copyWith(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          address ?? '',
                                          style: textStyle14Small,
                                        ),
                                        InkWell(
                                            onTap: () =>  cart.removeAddressFromList(cart.addressList[index]['address']),
                                            child: Text('remove', style: textStyle14Small.copyWith(color: Colors.red),))
                                      ],
                                    ),
                                  ),
                                  Checkbox(
                                    value: cart.checkedValue == index ? cart.isChecked : false,
                                    onChanged: (bool? value){
                                      cart.setChecked(value, index);
                                    },
                                    shape: const CircleBorder(),
                                    activeColor: secondaryColor,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
                // Center(
                //   child: QrImage(
                //     data: 'This is a simple QR code',
                //     version: QrVersions.auto,
                //     size: 220,
                //     gapless: false,
                //   ),
                // ),
                // SpaceDivider(height: 50,),
                // Padding(
                //   padding: defaultHPadding,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('Purchase Code', style: textStyle400Small,),
                //        EditTextSignUp(
                //         textInputType: TextInputType.emailAddress,
                //         controller: null,
                //         labelText: "0123456",
                //         readOnly: true,
                //         enabled: false,
                //         suffix: Icon(Icons.qr_code_scanner_outlined, size: 30, color: secondaryColor,)
                //       )
                //     ],
                //   ),
                // ),
                // SpaceDivider(height: 50,),
                // Padding(
                //   padding: defaultHPadding,
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('1. Copy account number', style: textStyle400Small.copyWith(color: accentColor),),
                //       kVerySmallHeight,
                //       Text('2. Transfer amount to top-up with', style: textStyle400Small.copyWith(color: accentColor)),
                //       kVerySmallHeight,
                //       Text('3. Transaction is verified, and wallet funded', style: textStyle400Small.copyWith(color: accentColor)),
                //     ],
                //   ),
                // )


              ],
            ),
          ),
        ),
        secondChild:
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('VAT: ', style: textStyle400Small),
                Text('₦ 500', style: textStyle400Small),
              ],
            ),
            const SpaceDivider(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('TOTAL: ', style: textStyle400Small),
                Text('₦ ${addSeparator(toDecimalPlace(cart.calculatedAmount))}', style: textStyle600Small),
              ],
            ),
            kSmallHeight,
            CustomButton(
              text: "MAKE PAYMENT ONLINE",
              onPressed: () => openDialog(context, TransactionDialog(
                mainText: 'Make Payment',
                subText: 'Make payment with either Wallet or Card',
                firstIcon: Assets.wallet,
                firstItemText: 'Pay With Wallet',
                secondIcon: Assets.card,
                secondItemText: 'Card or Bank Account',
                firstItemTap: () => navigate(context, const PayWithWallet()),
                secondItemTap: () => navigate(context, const CardTransfer()),
              )),
            ),
            // kSmallHeight,
            // InkWell(
            //   onTap: () => navigate(
            //       context,
            //       AccountCreated(
            //         onPressed: () => const AppLayout(),
            //         mainText: 'Transaction Successful',
            //         buttonText: 'MAKE ANOTHER PURCHASE',
            //         fabText: 'Go to Dasboard Instead',
            //         showFab: true,
            //       )),
            //   child: Text(
            //     'Pay With Cash',
            //     style: textStyleSecondary,
            //
            //   ),
            // )
          ],
        )
    );
  }
}

class CartBox extends StatefulWidget {
  const CartBox({Key? key, required this.amount}) : super(key: key);

  final int amount;

  @override
  State<CartBox> createState() => _CartBoxState();
}

class _CartBoxState extends State<CartBox> {
  @override
  Widget build(BuildContext context) {
    CartMixin cart = CartMixin.cartProvider(context, listen: true);
    return Row(
      children: [
        CartButtons(
          color: greyishColor,
          item: '-',
          onTap: () {
            cart.reducePrice();
            cart.reduceAmount(widget.amount);
          },
        ),
        CartButtons(
          color: whiteColor,
          item: cart.quantity.toString(),
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        CartButtons(
          color: greyishColor,
          item: '+',
          onTap: () {
            cart.addPrice();
            cart.increaseAmount(widget.amount);
          },
        ),

      ],
    );

  }
}


class CartButtons extends StatelessWidget {
  const CartButtons({
    Key? key, this.color, this.item, this.fontWeight, this.fontSize, this.onTap, this.padding,
  }) : super(key: key);

  final Color? color;
  final String? item;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Function()? onTap;
  final EdgeInsets? padding;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => null,
      child: Container(
        padding: padding ?? defaultCartPadding,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6)
        ),
        child:  Text(item!, style: textStyle400Small.copyWith(fontSize: fontSize ?? 20, fontWeight: fontWeight ?? FontWeight.w400 ),),
      ),
    );
  }
}
