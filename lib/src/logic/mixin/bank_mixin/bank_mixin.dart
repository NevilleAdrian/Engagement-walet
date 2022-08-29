
import 'package:engagementwallet/src/logic/models/mock_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankMixin extends ChangeNotifier {
  final List<Map<String, String>> _bankList = bankData;


  List<Map<String, String>> get bankList => _bankList;



  static BuildContext? _context;



  removeItemFromList(String? id){
    _bankList.removeWhere((element) => element['id'] == id);
    notifyListeners();
  }


  static BankMixin bankProvider(BuildContext context, {bool listen = false}) {
    _context = context;
    return Provider.of<BankMixin>(context, listen: listen);
  }
}
