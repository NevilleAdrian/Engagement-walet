import 'package:flutter/material.dart';

class EngagagementWalletApp extends StatefulWidget {
  const EngagagementWalletApp(
      {Key? key, required this.child}

  ) : super(key: key);

  final Widget child;
  @override
  State<EngagagementWalletApp> createState() => _EngagagementWalletAppState();
}

class _EngagagementWalletAppState extends State<EngagagementWalletApp> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
