import 'package:engagementwallet/src/utils/colors.dart';
import 'package:flutter/material.dart';

class CirclePlus extends StatelessWidget {
  const CirclePlus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: whiteColor,
      radius: 23,
      child: Icon(
        Icons.add,
        color: secondaryColor,
      ),
    );
  }
}
