import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


navigateReplaces(context, Widget route,
    {isDialog = false, RouteSettings? routeSettings}) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (BuildContext ctx) => route, settings: routeSettings),
  );
}

Future navigate(BuildContext context, Widget route,
        {isDialog = false,
        RouteSettings? routeSettings,
        bool maintainState = false}) async =>
    Navigator.push(
      context,
      MaterialPageRoute(
          maintainState: maintainState,
          fullscreenDialog: isDialog,
          builder: (context) => route,
          settings: routeSettings),
    );

popToFirst(BuildContext context) =>
    Navigator.of(context).popUntil((route) => route.isFirst);

popView(BuildContext context) => Navigator.pop(context);

pushAndRemoveUntil(BuildContext context, Widget screen) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => screen),
            (route) => false);

