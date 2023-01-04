import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/logic/models/app_model/app_model.dart';
import 'package:engagementwallet/src/logic/repository/hive_repository.dart';
import 'package:engagementwallet/src/ui/app_layout/app_layout.dart';
import 'package:engagementwallet/src/ui/onboarding/onboarding.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/utils/constants.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final HiveRepository _hiveRepository = HiveRepository();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () => _prepareAppState());
    super.initState();
  }

  _prepareAppState() async {
    await HiveRepository.openHives([
      kTokenName,
    ]);
    // AuthUser? user;
    AppModel? appModel;

    try {
      appModel = _hiveRepository.get<AppModel>(key: 'token', name: kTokenName);
    } catch (ex) {
      print(ex);
    }

    if (appModel?.token! == null) {
      navigateReplaces(context, const OnBoardingScreen());
    } else {
      AuthMixin.auth(context).setToken(appModel!.token!);
      pushAndRemoveUntil(context, const AppLayout());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        child: Center(
            child: SvgPicture.asset(
          Assets.logo,
          height: 100,
        )),
      ),
    );
  }
}
