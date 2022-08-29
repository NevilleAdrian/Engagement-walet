import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:engagementwallet/src/logic/mixin/bank_mixin/bank_mixin.dart';
import 'package:engagementwallet/src/ui/app_layout/more/friends/add_friend.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedBanks extends StatefulWidget {
  const SavedBanks({Key? key}) : super(key: key);

  @override
  State<SavedBanks> createState() => _SavedBanksState();
}

class _SavedBanksState extends State<SavedBanks> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BankMixin banks = BankMixin.bankProvider(context, listen: true);

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
              Text('Saved Banks', style: textStyleBig.copyWith(fontSize: 26)),
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
          padding: defaultHPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ConstrainedBox(
              //   constraints: const BoxConstraints(maxWidth: 100),
              //   child: const Text(
              //     'Provide your active phone number. This would ensure identity verification.',
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              kNormalHeight,
              SizedBox(
                height: 500.h,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      SpaceDivider(
                        height: 40,
                      ),
                  itemCount: banks.bankList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final bank = banks.bankList[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  bank['bankName']!,
                                  style: textStyle400Small,
                                ),
                                Text(
                                  '${bank['accountNumber']!} - ${bank['customerName']!}',
                                  style: textStyle14Small.copyWith(
                                      color: darkGreyColor),
                                ),
                              ],
                            )
                          ],
                        ),
                        InkWell(
                            onTap: () =>
                                banks.removeItemFromList(bank['id']),
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                            ))
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
