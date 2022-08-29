import 'package:engagementwallet/src/logic/models/mock_data.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
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
              Text('My Transactions',
                  style: textStyleBig.copyWith(fontSize: 26)),
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
        // Padding(
        //   padding: defaultVHPadding,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.stretch,
        //     children: [
        //       ConstrainedBox(
        //         constraints: const BoxConmystraints(maxWidth: 260),
        //         child: const Text(
        //           'Provide your active phone number. This would ensure identity verification.',
        //           textAlign: TextAlign.center,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        kSmallHeight,
        Container(
          height: 500,
          padding: defaultVHPadding,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const SpaceDivider(
              height: 50,
            ),
            itemCount: transactionHistory.length,
            itemBuilder: (BuildContext context, int index) {
              final transaction = transactionHistory[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction['type'],
                        style: textStyle600Small,
                      ),
                      kVerySmallHeight,
                      Text(
                        transaction['date'],
                        style: textStyle400Small,
                      ),
                    ],
                  ),
                  Text('N${transaction['amount']}',
                      style: textStyle14Small.copyWith(color: secondaryColor)),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
