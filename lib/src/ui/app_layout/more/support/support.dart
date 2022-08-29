import 'package:checkbox_grouped/checkbox_grouped.dart';
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
import 'package:flutter_svg/flutter_svg.dart';

class Support extends StatefulWidget {
  const Support({Key? key}) : super(key: key);

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  void initState() {
    super.initState();
  }

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
              Text('Support', style: textStyleBig.copyWith(fontSize: 26)),
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
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 100),
                child: const Text(
                  'If you have any issues within our platform you’d like us to solve, contact us today.',
                  textAlign: TextAlign.center,
                ),
              ),
              kNormalHeight,
              Padding(
                padding: defaultHPadding,
                child: Column(
                  children:  [
                    const SupportItems(
                      mainText: 'Email Address',
                      subText: 'support@izifin.com',
                      image: Assets.email,
                    ),
                    kSmallHeight,
                    const SupportItems(
                      mainText: 'Phone Number',
                      subText: '+234 901 2345 567',
                      image: Assets.phone,
                    ),
                  ],
                ),
              )

            ],
          ),
        )
      ],
    );
  }
}

class SupportItems extends StatelessWidget {
  const SupportItems({
    Key? key, this.mainText, this.subText, this.image,
  }) : super(key: key);

  final String? mainText;
  final String? subText;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: defaultVHPadding.copyWith(bottom: 20),
      decoration: BoxDecoration(
        color: shadeSecondaryColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: secondaryColor, width: 1)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(mainText!),
              kVerySmallHeight,
              Text(subText!, style: textStyleBig.copyWith(fontSize: 18),),

            ],
          ),
          SvgPicture.asset(image!)
        ],
      ),
    );
  }
}
