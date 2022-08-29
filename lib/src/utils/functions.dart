 import 'package:clipboard/clipboard.dart';
import 'package:engagementwallet/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

copy(String text) {
   FlutterClipboard.copy(text)
       .then((value) =>
       Fluttertoast.showToast(
           msg: "Copied!",
           toastLength:
           Toast.LENGTH_SHORT,
           gravity:
           ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor:
           secondaryColor,
           textColor: whiteColor,
           fontSize: 16.0));
 }

 String toDecimalPlace(dynamic item, [int value = 0]) {
   return item.toStringAsFixed(value);
 }

 String addSeparator(String item) {
   return item.replaceAllMapped(
       RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
 }

 Color colorType(String stat) {
   if (stat == 'Delivered') {
     return secondaryColor;
   } else if (stat == 'Pending'){
     return darkOrangeColor;
   }
   else {
     return Colors.redAccent;
   }
 }
 String formatDate(String time) {
   var formatter =  DateFormat('yyyy-MM-dd, hh:mm:ss');
   String formattedDate = formatter.format(DateTime.parse(time));
   return formattedDate;
 }

 void showFlush(BuildContext context, String message, [Color? color]) {
   Fluttertoast.showToast(
     msg: message,
     toastLength: Toast.LENGTH_LONG,
     gravity: ToastGravity.BOTTOM,
     timeInSecForIosWeb: 1,
     backgroundColor: secondaryColor,
     textColor: Colors.white,
     fontSize: 16.0,
   );



 }

 Widget circularProgressIndicator() => CircularProgressIndicator(
   strokeWidth: 2,
   backgroundColor: Colors.white,
   valueColor: AlwaysStoppedAnimation<Color>(secondaryColor),
 );