import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionDialog extends StatelessWidget {
  const TransactionDialog({Key? key, this.mainText, this.subText, this.firstIcon, this.firstItemText, this.secondIcon, this.secondItemText, this.firstItemTap, this.secondItemTap}) : super(key: key);

  final String? mainText;
  final String? subText;
  final String? firstIcon;
  final String? firstItemText;
  final String? secondIcon;
  final String? secondItemText;
  final Function()? firstItemTap;
  final Function()? secondItemTap;


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
              Text(mainText!,
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
        Padding(
          padding: defaultVHPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 260),
                child:  Text(
                  subText ?? 'Provide your active phone number. This would ensure identity verification.',
                  textAlign: TextAlign.center,
                ),
              ),

              kSmallHeight,


            ],
          ),
        ),
        Column(
          children: [
            Padding(
              padding: defaultHPadding,
              child: InkWell(
                onTap: firstItemTap,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(firstIcon!),
                    kSmallWidth,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(firstItemText!, style: textStyle600Small,),
                        kVerySmallHeight,
                        ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 300),
                            child: Text('Make Payment via Bank transfer', style: textStyle400Small.copyWith(color: darkGreyColor),))

                      ],
                    )
                  ],
                ),
              ),
            ),
            SpaceDivider(height: 40,),
            Padding(
              padding: defaultHPadding,
              child: InkWell(
                onTap: secondItemTap,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(secondIcon!),
                    kSmallWidth,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(secondItemText!, style: textStyle600Small,),
                        kVerySmallHeight,
                        ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 300),
                            child: Text('Make Payment via Card', style: textStyle400Small.copyWith(color: darkGreyColor),))

                      ],
                    )
                  ],
                ),
              ),
            )

          ],
        ),

      ],
    );
  }
}
