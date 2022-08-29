import 'package:engagementwallet/src/logic/mixin/app_mixins/app_mixin.dart';
import 'package:engagementwallet/src/ui/splash/splashscreen.dart';
import 'package:engagementwallet/src/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EngagementWalletHome extends StatefulWidget {
  const EngagementWalletHome({Key? key}) : super(key: key);

  @override
  State<EngagementWalletHome> createState() => _EngagementWalletHomeState();
}

class _EngagementWalletHomeState extends State<EngagementWalletHome> {
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: appProviders,
      child: ScreenUtilInit(
        designSize: Size(414, 896),
        builder: () => MaterialApp(
          title: 'Engagement Wallet',
          theme: myThemeData(context),
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
