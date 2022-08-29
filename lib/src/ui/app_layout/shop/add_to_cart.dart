import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/logic/mixin/cart_mixin/cart_mixin.dart';
import 'package:engagementwallet/src/ui/app_layout/app_layout.dart';
import 'package:engagementwallet/src/ui/app_layout/home/top_up/top_up.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/shop_description.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/store_pop_up.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/backgrounds/authentication_backgrounds.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({Key? key}) : super(key: key);

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {

  @override
  void initState() {
    // print('number ${1 + 1}');
    if(CartMixin.cartProvider(context).cartList.isNotEmpty){
      CartMixin.cartProvider(context).calculateSumInCart();


    }
    final List<Map<String, dynamic>> list = CartMixin.cartProvider(context, listen: false).cartList;
    // CartMixin.cartProvider(context).setInitialList(list);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    CartMixin cart = CartMixin.cartProvider(context, listen: true);

    return AuthenticationBackGround(
        height: 1.4.h,
        childPadding: defaultVHPadding.copyWith(bottom: 30),
        child: Container(
          color: whiteColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('My Cart',
                        style: textStyle600Small.copyWith(fontSize: 26)),
                    InkWell(
                      onTap: () => navigate(context, const AppLayout()),
                      child: Icon(
                        Icons.close,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
                kNormalHeight,
                Container(
                  height: 500,
                  padding: const EdgeInsets.only(bottom: 30),
                  child: ListView.separated(
                      itemCount: cart.cartList.length,
                      separatorBuilder: (context, index) => const SpaceDivider(
                            height: 40,
                          ),
                      itemBuilder: (context, index) {
                        final cartItem = cart.cartList[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(cartItem['image']),
                                      ),
                                    ),
                                  ),
                                  kVerySmallWidth,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints(maxWidth: 200),
                                        child: Text(
                                          cartItem['product'],
                                          style: textStyle14Small.copyWith(fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      kVerySmallHeight,
                                      Row(
                                        children: [
                                          CartButtons(
                                            color: greyishColor,
                                            item: '-',
                                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                            onTap: () {
                                              cart.reduceCartPrice(index);
                                            },
                                          ),
                                          CartButtons(
                                            color: whiteColor,
                                            item: cartItem['quantity'].toString(),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          CartButtons(
                                            color: greyishColor,
                                            item: '+',
                                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                            onTap: () {
                                              cart.addCartPrice(index);
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '₦${addSeparator(
                                      toDecimalPlace(cartItem['amount']),
                                    )}',
                                    style: textStyle600Small,
                                  ),
                                   kVerySmallHeight,
                                   InkWell(
                                     child: const Text(
                                      'remove',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.red),
                                  ),
                                       onTap: () {
                                         cart.removeItemFromList(cartItem['id']);
                                         cart.reduceCartPrice(index);

                                       }

                                   )
                                ],
                              ),
                            )
                          ],
                        );
                      }),
                )
              ],
            ),
          ),
        ),
        secondChild: Column(
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
            // CustomButton(
            //   text: "CHECKOUT",
            //   loader: false,
            //   color: cart.cartList.isEmpty ? greyColor : secondaryColor ,
            //   onPressed:  () => cart.cartList.isEmpty ? null : openDialog(context, const StorePopUp()),
            // ),

            CustomButton(
                text: "CHECKOUT",
                loader: CartMixin.cartProvider(context, listen: true).isLoading,
                onPressed: () async {
                  await cart.getPaymentOptions(context);
                }),
          ],
        )
    );
  }
}
