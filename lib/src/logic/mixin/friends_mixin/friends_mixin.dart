import 'package:engagementwallet/src/logic/helper/network_helper.dart';
import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/logic/models/friends_model/friends_model.dart';
import 'package:engagementwallet/src/logic/repository/hive_repository.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/friends_model/friend_list_model.dart';

class FriendsMixin extends ChangeNotifier {
  FriendsMixin(this._helper, this._hiveRepository);
  final NetworkHelper _helper;
  final HiveRepository _hiveRepository;
  List<FriendsList> _friendsList = [];
  List<SearchFriends> _friends = [];
  bool _checked = false;
  String _userID = '';

  List<FriendsList> get friendsList => _friendsList;
  List<SearchFriends> get friends => _friends;
  bool get checked => _checked;
  String get userID => _userID;

  setFriends(List<SearchFriends> friends) => _friends = friends;
  setFriendList(List<FriendsList> friendList) => _friendsList = friendList;
  setChecked(bool checked, String id) {
    _checked = checked;
    _userID = id;
    notifyListeners();
  }

  static BuildContext? _context;

  ///1. Get friends
  Future<List<FriendsList>?> getFriendList(BuildContext context) async {
    try {
      ///1.Call Get friends
      var data = await _helper.getFriendList(AuthMixin.auth(context).token!);

      print('data: $data');

      List<FriendsList> friends =
          (data['data'] as List).map((e) => FriendsList.fromJson(e)).toList();

      ///2b. Set friends
      setFriendList(friends);

      notifyListeners();

      print('SearchFriendss: ${_friendsList}');

      return friends;
    } catch (ex) {
      ///5.Set Loading state to false
      print('ex: $ex');
      AuthMixin.auth(context).setIsLoading(false);
      notifyListeners();
    }
  }

  ///2. Search friends
  Future<dynamic> searchFriends(String name, BuildContext context) async {
    try {
      ///1. Set Loading state to true
      AuthMixin.auth(context).setIsLoading(true);
      notifyListeners();

      ///2.Call Get friends
      var data =
          await _helper.searchFriends(AuthMixin.auth(context).token!, name);

      print('data: $data');

      List<SearchFriends> friends =
          (data['data'] as List).map((e) => SearchFriends.fromJson(e)).toList();

      print('SearchFriends: $friends');

      ///2b. Set friends
      setFriends(friends);
      notifyListeners();

      ///3.Set Loading state to false
      AuthMixin.auth(context).setIsLoading(false);
      notifyListeners();
    } catch (ex) {
      ///5.Set Loading state to false
      print('ex: $ex');
      AuthMixin.auth(context).setIsLoading(false);
      notifyListeners();
    }
  }

  ///2. Search friends
  Future<dynamic> addFriends(BuildContext context) async {
    try {
      ///1. Set Loading state to true
      AuthMixin.auth(context).setIsLoading(true);
      notifyListeners();

      ///2.Call Get friends
      var data =
          await _helper.addFriends(AuthMixin.auth(context).token!, userID);

      print('data: $data');

      showFlush(context, 'Successfully added friend');

      popView(context);

      // List<SearchFriends> friends = (data['data'] as List).map((e) => SearchFriends.fromJson(e)).toList();
      //
      // print('SearchFriends: $friends');
      //
      // ///2b. Set friends
      // setFriends(friends);
      // notifyListeners();

      ///3.Set Loading state to false
      AuthMixin.auth(context).setIsLoading(false);
      notifyListeners();
    } catch (ex) {
      ///5.Set Loading state to false
      print('ex: $ex');
      AuthMixin.auth(context).setIsLoading(false);
      notifyListeners();
    }
  }

  ///3. Search friends
  Future<dynamic> acceptFriendRequest(
      String requestID, bool value, BuildContext context) async {
    try {
      ///1. Set Loading state to true
      AuthMixin.auth(context).setIsLoading(true);
      notifyListeners();

      ///2.Call Get friends
      var data = await _helper.acceptFriendRequest(
          requestID, value, AuthMixin.auth(context).token!);

      print('data: $data');

      showFlush(context, 'Accepted friend');

      await getFriendList(context);

      ///3.Set Loading state to false
      AuthMixin.auth(context).setIsLoading(false);
      notifyListeners();
    } catch (ex) {
      ///5.Set Loading state to false
      print('ex: $ex');
      AuthMixin.auth(context).setIsLoading(false);
      notifyListeners();
    }
  }

  // removeItemFromList(String? id) {
  //   _friendsList.removeWhere((element) => element['id'] == id);
  //   notifyListeners();
  // }

  // setFriendList(Map<String, String> friendItems) {
  //   _friendsList.add(friendItems);
  //   notifyListeners();
  // }

  static FriendsMixin friendProvider(BuildContext context,
      {bool listen = false}) {
    _context = context;
    return Provider.of<FriendsMixin>(context, listen: listen);
  }
}
