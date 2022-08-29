import 'package:engagementwallet/src/utils/colors.dart';
import 'package:engagementwallet/values/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pin_put/pin_put.dart';

class PinValidation extends StatelessWidget {
  const PinValidation({
    Key? key,
    required TextEditingController pinController,
    this.width = 50,
    this.count = 6,
  })  : _pinController = pinController,
        super(key: key);

  final TextEditingController _pinController;
  final double width;
  final int count;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: PinPut(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        selectedFieldDecoration: pinPutDecoration,
        followingFieldDecoration: pinPutDecoration.copyWith(
          border: Border.all(color: Colors.grey.withAlpha(200)),
        ),
        withCursor: true,
        inputDecoration: const InputDecoration(
            border: InputBorder.none, enabledBorder: InputBorder.none),
        submittedFieldDecoration: pinPutDecoration.copyWith(
          border: Border.all(color: secondaryColor),
        ),
        fieldsCount: count,
        controller: _pinController,
        eachFieldWidth: width,
        eachFieldHeight: 60.0,
        autofocus: false, pinAnimationType: PinAnimationType.fade,
        onSubmit: (value) {
          FocusScope.of(context).unfocus();
        },
        onChanged: (val) {},
        obscureText: '*',

        keyboardType: TextInputType.number,
        textStyle: const TextStyle(fontSize: 20, height: 1),
        animationDuration: const Duration(milliseconds: 80),
        // animationCurve:Curve.linear
      ),
    );
  }
}
