import 'package:engagementwallet/src/logic/helper/network_helper.dart';
import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/logic/mixin/bank_mixin/bank_mixin.dart';
import 'package:engagementwallet/src/logic/mixin/cart_mixin/cart_mixin.dart';
import 'package:engagementwallet/src/logic/mixin/friends_mixin/friends_mixin.dart';
import 'package:engagementwallet/src/logic/mixin/page_controller_mixin.dart';
import 'package:engagementwallet/src/logic/repository/hive_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<PageMixin>(create: (_) => PageMixin()),
  ChangeNotifierProvider<CartMixin>(create: (_) => CartMixin(NetworkHelper(), HiveRepository())),
  ChangeNotifierProvider<FriendsMixin>(create: (_) => FriendsMixin(NetworkHelper(), HiveRepository())),
  ChangeNotifierProvider<BankMixin>(create: (_) => BankMixin()),
  ChangeNotifierProvider<AuthMixin>(create: (_) => AuthMixin(NetworkHelper(), HiveRepository())),
];
