import 'package:engagementwallet/src/logic/bloc/auth_bloc/validation_bloc.dart';
import 'package:engagementwallet/src/logic/future_helper/future_helper.dart';
import 'package:engagementwallet/src/logic/mixin/cart_mixin/cart_mixin.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/new_address.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/back_arrow.dart';
import 'package:engagementwallet/src/widgets/backgrounds/authentication_backgrounds.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryPurchase extends StatefulWidget {
  const DeliveryPurchase({Key? key}) : super(key: key);

  @override
  State<DeliveryPurchase> createState() => _DeliveryPurchaseState();
}

class _DeliveryPurchaseState extends State<DeliveryPurchase> {
  final validator = ValidationBloc();
  TextEditingController bankNameCC = TextEditingController();
  TextEditingController accountNumberCC = TextEditingController();
  TextEditingController amountCC = TextEditingController();

  String bankCode = '';

  Future<List<dynamic>>? futureAddress;

  //2. Call Api here
  Future<List<dynamic>>? futureTask() async {
    //Initialize provider
    CartMixin cart = CartMixin.cartProvider(context);

    final result = await cart.getAddress(context);

    setState(() {});
    //
    //Return future value
    return Future.value(result);
  }

  ///3. Set Future users to the task
  @override
  void initState() {
    futureAddress = futureTask();
    super.initState();
  }

  @override
  void dispose() {
    validator.dispose();
    bankNameCC.dispose();
    accountNumberCC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CartMixin cart = CartMixin.cartProvider(context, listen: true);

    return AuthenticationBackGround(
        padding: EdgeInsets.zero,
        height: 1.8.h,
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
                    'Delivery Purchase',
                    style: textStyleBig.copyWith(fontSize: 26),
                  ),
                  kSmallHeight,
                  Text(
                    'Make Payments either via our payment provider or directly to the store ',
                    style: textStyle400Small,
                  ),
                  kSmallHeight,
                  Column(
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
                      FutureHelper(
                        task: futureAddress!,
                        loader: Center(
                          child: circularProgressIndicator(),
                        ),
                        noData: const Center(
                          child: Text('No Friend Request'),
                        ),
                        builder: (context, _) => Container(
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: secondaryColor),
                            color: otherColor,
                          ),
                          child: ListView.separated(
                            itemCount: cart.addressList.length,
                            separatorBuilder: (context, index) =>
                                const SpaceDivider(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            address ?? '',
                                            style: textStyle14Small,
                                          ),
                                          InkWell(
                                              onTap: () =>
                                                  cart.removeAddressFromList(
                                                      cart.addressList[index]
                                                          ['address']),
                                              child: Text(
                                                'remove',
                                                style:
                                                    textStyle14Small.copyWith(
                                                        color: Colors.red),
                                              ))
                                        ],
                                      ),
                                    ),
                                    Checkbox(
                                      value: cart.checkedValue == index
                                          ? cart.isChecked
                                          : false,
                                      onChanged: (bool? value) {
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
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
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
            const SpaceDivider(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('TOTAL: ', style: textStyle400Small),
                Text('₦ ${addSeparator(toDecimalPlace(cart.calculatedAmount))}',
                    style: textStyle600Small),
              ],
            ),
            kNormalHeight,
            // CustomButton(
            //   text: "MAKE PAYMENT ONLINE",
            //   onPressed: () => openDialog(context, TransactionDialog(
            //     mainText: 'Make Payment',
            //     firstIcon: Assets.wallet,
            //     firstItemText: 'Pay With Wallet',
            //     secondIcon: Assets.card,
            //     secondItemText: 'Card or Bank Account',
            //     firstItemTap: () => navigate(context, const PayWithWallet()),
            //     secondItemTap: () => navigate(context, const CardTransfer()),
            //   )),
            // ),
            // kSmallHeight,

            CustomButton(
                text: "Pay With Cash",
                loader: CartMixin.cartProvider(context, listen: true).isLoading,
                onPressed: () =>
                    CartMixin.cartProvider(context).checkOut(context, 0)),

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
        ));
  }
}
