import 'package:engagementwallet/src/logic/future_helper/future_helper.dart';
import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/logic/models/user_model/user_model.dart';
import 'package:engagementwallet/src/ui/app_layout/home/top_up/top_up.dart';
import 'package:engagementwallet/src/ui/app_layout/home/transfer/make_transfer.dart';
import 'package:engagementwallet/src/ui/app_layout/home/withdraw/withdraw_balance.dart';
import 'package:engagementwallet/src/ui/app_layout/shop/shop.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/circle_plus.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/src/widgets/space_divider.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:engagementwallet/values/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<User>? futureUser;

  //2. Call Api here
  Future<User>? futureTask() async {
    //Initialize provider
    AuthMixin cart = AuthMixin.auth(context);

    final result = await cart.getUsers(context);

    setState(() {});
    //
    //Return future value
    return Future.value(result);
  }

  ///3. Set Future users to the task
  @override
  void initState() {
    futureUser = futureTask();
    super.initState();
  }

  bool change = true;
  @override
  Widget build(BuildContext context) {
    AuthMixin auth = AuthMixin.auth(context, listen: true);
    return Scaffold(
      appBar: const TopNavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: defaultVHPadding,
              child: Column(
                children: [
                  FutureHelper(
                    task: futureUser!,
                    loader: Center(
                      child: circularProgressIndicator(),
                    ),
                    noData: const Center(
                      child: Text('No User Information'),
                    ),
                    builder: (context, _) => Row(
                      children: [
                        auth.user.profileImage != null
                            ? CircleAvatar(
                                child: Image.network(auth.user.profileImage!),
                                backgroundColor: primaryColor,
                              )
                            : Image.asset(Assets.male),
                        kVerySmallWidth,
                        RichText(
                          text: TextSpan(
                              text: 'Welcome ',
                              style: textStyle400Small,
                              children: [
                                TextSpan(
                                    text: auth.user.firstName,
                                    style: textStyle600Small)
                              ]),
                        )
                      ],
                    ),
                  ),
                  kSmallHeight,
                  TransferBox(
                    amount: '₦345,000',
                    change: change,
                    onTap: () {
                      setState(() {
                        change = !change;
                      });
                    },
                    onTapWithdraw: () {
                      navigate(context, const WithdrawBalance());
                    },
                    onTapTransfer: () {
                      navigate(context, const MakeTransfer());
                    },
                    onTopUp: () => openDialog(context, const TopUp()),
                  ),
                  const ShopScreen()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: otherColor,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Image.asset(Assets.kfc),
      ),
      title: Text('KFC Engagement Wallet', style: textStyle400Small),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: SvgPicture.asset(Assets.qrCode),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(65);
}

class TransferBox extends StatelessWidget {
  const TransferBox({
    Key? key,
    required this.change,
    required this.onTap,
    required this.amount,
    required this.onTapWithdraw,
    required this.onTapTransfer,
    required this.onTopUp,
  }) : super(key: key);

  final bool change;
  final Function() onTap;
  final Function() onTapWithdraw;
  final Function() onTapTransfer;
  final Function() onTopUp;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            onTap: onTap,
            child: SvgPicture.asset(change ? Assets.box1 : Assets.box2),
          ),
          Positioned(
            top: 50,
            child: Container(
              width: 378.w,
              decoration: BoxDecoration(
                  color: change ? secondaryColor : darkPrimaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.circular(change ? 22 : 0),
                      bottomRight: const Radius.circular(22),
                      bottomLeft: const Radius.circular(22))),
              child: Column(
                children: [
                  Padding(
                    padding: defaultVHPadding,
                    child: Column(
                      children: [
                        InkWell(
                          child: Row(
                            mainAxisAlignment: change
                                ? MainAxisAlignment.spaceBetween
                                : MainAxisAlignment.center,
                            children: [
                              Text(amount, style: textStyleBigWhite),
                              change
                                  ? InkWell(
                                      onTap: onTopUp, child: const CirclePlus())
                                  : Container()
                            ],
                          ),
                        ),
                        kSmallHeight,
                      ],
                    ),
                  ),
                  SpaceDivider(
                    height: 5,
                    color: whiteColor.withOpacity(0.2),
                  ),
                  Padding(
                    padding: defaultHPadding.copyWith(top: 0),
                    child: Row(
                      mainAxisAlignment: change
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.center,
                      children: [
                        !change
                            ? Container()
                            : GestureDetector(
                                onTap: onTapWithdraw,
                                child: Text('Withdraw balance',
                                    style: textStyleSmallYellow),
                              ),
                        Container(
                          height: 65.h,
                          color: !change ? darkPrimaryColor : Colors.white,
                          width: 0.5,
                        ),
                        GestureDetector(
                          onTap: onTapTransfer,
                          child: Text('Make Transfer',
                              style: textStyleSmallWhite.copyWith(
                                  color:
                                      change ? Colors.white : secondaryColor)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
