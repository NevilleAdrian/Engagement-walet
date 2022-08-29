import 'package:engagementwallet/src/app.dart';
import 'package:engagementwallet/src/home.dart';
import 'package:engagementwallet/src/logic/models/app_model/app_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pp;
import 'package:hive/hive.dart';

void main() async{
  await _openHive();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EngagagementWalletApp(
    child: EngagementWalletHome(),
  ));
}
_openHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocDir = await pp.getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  Hive.registerAdapter(AppModelAdapter());
}




