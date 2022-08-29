import 'package:engagementwallet/src/utils/sized_boxes.dart';
import 'package:engagementwallet/src/widgets/backgrounds/onboarding_background.dart';
import 'package:engagementwallet/values/padding.dart';
import 'package:flutter/material.dart';

class AuthenticationBackGround extends StatelessWidget {
  const AuthenticationBackGround({
    Key? key, required this.child, required this.secondChild, this.height = 1.4, this.padding, this.childPadding,
  }) : super(key: key);

  final Widget child;
  final Widget secondChild;
  final double height;
  final EdgeInsets? padding;
  final EdgeInsets? childPadding;

  @override
  Widget build(BuildContext context) {
    return OnBoardinglayout(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/images/png/auth-bg.png'),
                    fit: BoxFit.cover,
                  ),
                ),

                child: SafeArea(
                    child: Padding(
                      padding: padding ?? defaultVHPadding,
                      child: child,
                    )),
              ),
              if(childPadding != null)
              kSmallHeight,
              Padding(
                padding: childPadding ?? defaultHPadding,
                child: secondChild,
              )
            ],
          ),
        )
    );
  }
}
