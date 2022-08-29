import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/src/widgets/pin_widgets/verify_pin.dart';
import 'package:flutter/material.dart';

Future<dynamic> openDialog(BuildContext context, [Widget? widget, double? height, String? type = 'phone']) async {
  return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black.withOpacity(0.52),
          child: Container(
              height: MediaQuery.of(context).size.height * 1 / ( height ?? 1.1),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: widget ?? VerifyPin(type: type)),
        );
      });
}



