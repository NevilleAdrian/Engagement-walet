import 'package:engagementwallet/src/ui/app_layout/app_layout.dart';
import 'package:engagementwallet/src/ui/app_layout/home/home.dart';
import 'package:engagementwallet/src/ui/authentication/signup/account_created.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({Key? key}) : super(key: key);

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(),
      backgroundColor: darkishGreyColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: defaultVHPadding.copyWith(bottom: 50),
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('REWARDS',
                        style: textStyle600Small.copyWith(
                            fontSize: 18, color: darkPrimaryColor)),
                    kSmallHeight,
                    ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 260),
                        child: Text(
                            'Collect bonuses and rewards you have accrued over time',
                            style: textStyle400Small))
                  ],
                ),
              ),
              Container(
                height: 800,
                child: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(45),
                      child: AppBar(
                        backgroundColor: darkishGreyColor,
                        leading: Container(),
                        elevation: 0,
                        bottom: TabBar(
                          indicatorColor: secondaryColor,
                          isScrollable: true,
                          tabs: const [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text('All Challenges'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text('Daily Challenges'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text('Weekly Challenges'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    body: const TabBarView(
                      children: [
                        RewardItems(),
                        RewardItems(),
                        RewardItems(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RewardItems extends StatelessWidget {
  const RewardItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      padding: defaultVHPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(Assets.check),
                    kSmallWidth,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text('Make a purchase',
                              style: textStyle600Small.copyWith(fontSize: 18)),
                          kVerySmallHeight,
                          Text('Make an online purchase from us',
                              style: textStyle14Small),
                          kVerySmallHeight,
                          LinearPercentIndicator(
                            lineHeight: 4.0,
                            padding: EdgeInsets.zero,
                            percent: 0.5,
                            backgroundColor: whiteColor,
                            progressColor: secondaryColor,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () => navigate(
                    context,
                    const AccountCreated(
                        mainText: 'Reward Collected',
                        buttonText: 'VIEW WALLET')),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: lightSecondaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.coin,
                        height: 25,
                      ),
                      kSmallestWidth,
                      Text('N 100,000',
                          style: textStyleSecondary.copyWith(fontSize: 14)),
                    ],
                  ),
                ),
              )
            ],
          ),
          SpaceDivider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(Assets.trophy),
                    kSmallWidth,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Review a purchase',
                              style: textStyle600Small.copyWith(fontSize: 18)),
                          Text('Make an online purchase from us',
                              style: textStyle14Small),
                          kSmallHeight,
                          LinearPercentIndicator(
                            lineHeight: 4.0,
                            padding: EdgeInsets.zero,
                            percent: 0.5,
                            backgroundColor: whiteColor,
                            progressColor: orangeColor,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text('0/1')
            ],
          ),
          SpaceDivider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(Assets.trophy),
                    kSmallWidth,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Review a purchase',
                              style: textStyle600Small.copyWith(fontSize: 18)),
                          Text('Make an online purchase from us',
                              style: textStyle14Small),
                          kSmallHeight,
                          LinearPercentIndicator(
                            lineHeight: 4.0,
                            padding: EdgeInsets.zero,
                            percent: 0.5,
                            backgroundColor: whiteColor,
                            progressColor: orangeColor,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text('0/1')
            ],
          ),
          SpaceDivider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(Assets.trophy),
                    kSmallWidth,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Review a purchase',
                              style: textStyle600Small.copyWith(fontSize: 18)),
                          Text('Make an online purchase from us',
                              style: textStyle14Small),
                          kSmallHeight,
                          LinearPercentIndicator(
                            lineHeight: 4.0,
                            padding: EdgeInsets.zero,
                            percent: 0.5,
                            backgroundColor: whiteColor,
                            progressColor: orangeColor,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text('0/1')
            ],
          ),
        ],
      ),
    );
  }
}
