import 'package:engagementwallet/src/ui/app_layout/home/bank_transfer/bank_transfer.dart';
import 'package:engagementwallet/src/ui/app_layout/home/card_transfer/card_transfer.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/delivery_purchase.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/make_purchase.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/custom_button.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StorePopUp extends StatefulWidget {
  const StorePopUp({Key? key}) : super(key: key);

  @override
  State<StorePopUp> createState() => _StorePopUpState();
}

class _StorePopUpState extends State<StorePopUp> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                      Text('Pay Now or Pay Later',
                          style: textStyleBig.copyWith(fontSize: 26)),
                      Icon(
                        Icons.cancel,
                        color: whiteColor,
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Divider(
                      thickness: 0.8,
                      height: 15,
                      color: greyColor,
                    ),
                    // Padding(
                    //   padding: defaultVHPadding,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.stretch,
                    //     children: [
                    //       ConstrainedBox(
                    //         constraints: const BoxConstraints(maxWidth: 260),
                    //         child: const Text(
                    //           'Provide your active phone number. This would ensure identity verification.',
                    //           textAlign: TextAlign.center,
                    //         ),
                    //       ),
                    //       kSmallHeight,
                    //     ],
                    //   ),
                    // ),
                    kSmallHeight,
                    Column(
                      children: [
                        Padding(
                          padding: defaultHPadding,
                          child: InkWell(
                            onTap: () => navigate(context, const MakePurchase()),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Yes, I want to pay now',
                                      style: textStyle600Small,
                                    ),
                                    kVerySmallHeight,
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(maxWidth: 300),
                                      child: Text(
                                        'Click Yes! ',
                                        style: textStyle400Small.copyWith(
                                            color: darkGreyColor),
                                      ),
                                    )
                                  ],
                                ),
                                Icon(Icons.chevron_right)
                              ],
                            ),
                          ),
                        ),
                        SpaceDivider(
                          height: 40,
                        ),
                        Padding(
                          padding: defaultHPadding,
                          child: InkWell(
                            onTap: () => navigate(context, const DeliveryPurchase()),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "No, I want to pay on delivery",
                                      style: textStyle600Small,
                                    ),
                                    kVerySmallHeight,
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(maxWidth: 300),
                                      child: Text(
                                        "Click Yes!",
                                        style: textStyle400Small.copyWith(
                                            color: darkGreyColor),
                                      ),
                                    )
                                  ],
                                ),
                                Icon(Icons.chevron_right)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: defaultVHPadding,
              child: CustomWidgetButton(
                height: 90,
                  widget: Row(
                    children: [
                      Image.asset(Assets.coin),
                      kSmallWidth,
                       Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Get rewarded with '
                                ),
                                TextSpan(
                                    text: 'N200,000 ',
                                  style: textStyle600Small.copyWith(color: whiteColor, fontSize: 13)
                                ),
                                TextSpan(
                                    text: 'for making store purchases'
                                )
                              ]
                            ),
                          )
                      )
                    ],
                  ),
                  onPressed: () async => await openDialog(context)
              ),
            ),


        ],
      ),
    );
  }
}
