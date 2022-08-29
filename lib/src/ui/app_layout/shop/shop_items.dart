import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';

class ShopItems extends StatelessWidget {
  const ShopItems({
    Key? key, required this.onTap, required this.amount, required this.description, required this.image,
  }) : super(key: key);

  final Function() onTap;
  final int? amount;
  final String? description;
  final String image;

  @override
  Widget build(BuildContext context) {


    return InkWell(
      onTap: onTap,
      child: Container(
        padding: defaultPadding,
        decoration:  BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image:   DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  image
                )
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: defaultButtonPadding,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(30),

                  ),
                  child: Text('₦${addSeparator(toDecimalPlace(amount))}', style: textStyleSmallWhite.copyWith(fontSize: 12),),
                )
              ],
            ),
            Text(description!, style: textStyleSmallWhite)
          ],
        ),
      ),
    );
  }
}
