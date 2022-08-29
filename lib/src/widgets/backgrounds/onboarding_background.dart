import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/values/assets.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingBackground extends StatelessWidget {
  const OnboardingBackground(
      {Key? key,
      required this.child,
      required this.bottomChild,
      required this.bottomChildText,
      required this.rightSidedChild,
      this.showLayout = false})
      : super(key: key);

  final Widget child;
  final Widget bottomChild;
  final Widget bottomChildText;
  final Widget rightSidedChild;
  final bool showLayout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: primaryColor,
        child: Stack(
          children: [
            showLayout ? bottomChildText : Container(),
            showLayout ? bottomChild : Container(),
            showLayout ? rightSidedChild : Container(),
            child,
          ],
        ),
      ),
    );
  }
}

class OnBoardinglayout extends StatelessWidget {
  const OnBoardinglayout(
      {Key? key, required this.child, this.showLayout = false})
      : super(key: key);

  final Widget child;
  final bool showLayout;

  @override
  Widget build(BuildContext context) {
    return OnboardingBackground(
      showLayout: showLayout,
      rightSidedChild: Align(
        alignment: Alignment.bottomRight,
        child: SvgPicture.asset(Assets.man),
      ),
      bottomChild: Align(
        alignment: Alignment.bottomCenter,
        child: Image.asset(Assets.onboardingBg),
      ),
      bottomChildText: const Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text('Powered by Izifin technologies limited.'),
        ),
      ),
      child: child,
    );
  }
}
