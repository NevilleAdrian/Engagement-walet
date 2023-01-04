import 'package:engagementwallet/src/logic/exceptions/api_failure_exception.dart';
import 'package:engagementwallet/src/logic/helper/network_helper.dart';
import 'package:engagementwallet/src/logic/mixin/auth_mixin/auth_mixin.dart';
import 'package:engagementwallet/src/logic/models/cart_model/cart_model.dart';
import 'package:engagementwallet/src/logic/models/order_history_model/order_history_model.dart';
import 'package:engagementwallet/src/logic/models/payment_options/payment_options.dart';
import 'package:engagementwallet/src/logic/models/product_model/product_model.dart';
import 'package:engagementwallet/src/ui/app_layout/app_layout.dart';
import 'package:engagementwallet/src/ui/authentication/signup/account_created.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui/app_layout/shop/store_pop_up.dart';
import '../../repository/hive_repository.dart';

class CartMixin extends ChangeNotifier {
  CartMixin(this._helper, this._hiveRepository);
  final NetworkHelper _helper;
  final HiveRepository _hiveRepository;

  bool _isLoading = false;
  int _quantity = 1;
  late int _amount;
  late int _calculatedAmount = 0;
  late int? _checkedValue = 0;
  late bool? _isChecked = false;
  List<Map<String, dynamic>> _cartList = [];
  List<Map<String, dynamic>> _newCartList = [];
  List<Map<String, String>> _addressList = [];
  List<CartModel> _intitialList = [];
  List<OrderHistoryModel> _orderHistory = [];
  List<dynamic> _addresses = [];
  List<ProductModel> _products = [];
  List<PaymentOptions> _paymentOptions = [];

  bool get isLoading => _isLoading;
  int get quantity => _quantity;
  int get amount => _amount;
  int get checkedValue => _checkedValue!;
  bool get isChecked => _isChecked!;
  int get calculatedAmount => _calculatedAmount;
  List<Map<String, dynamic>> get cartList => _cartList;
  List<Map<String, dynamic>> get newCartList => _newCartList;
  List<CartModel> get intitialList => _intitialList;
  List<Map<String, String>> get addressList => _addressList;
  List<OrderHistoryModel> get orderHistory => _orderHistory;
  List<dynamic> get addresses => _addresses;
  List<ProductModel> get products => _products;
  List<PaymentOptions> get paymentOptions => _paymentOptions;

  static BuildContext? _context;

  setIsLoading(bool isLoading) => _isLoading = isLoading;
  setOrderHistory(List<OrderHistoryModel> orderHistory) =>
      _orderHistory = orderHistory;
  setAddresses(List<dynamic> addresses) => _addresses = addresses;
  setProducts(List<ProductModel> products) => _products = products;
  setPaymentOptions(List<PaymentOptions> paymentOptions) =>
      _paymentOptions = paymentOptions;

  removeAddressFromList(String? address) {
    _addressList.removeWhere((element) => element['address'] == address);
    notifyListeners();
  }

  setChecked(bool? checked, int? index) {
    _isChecked = checked;
    _checkedValue = index;
    notifyListeners();
  }

  reduceCartPrice(int objIndex) {
    if (_cartList.isNotEmpty) {
      if (_cartList[objIndex]['quantity'] > 1) {
        _cartList[objIndex]['quantity'] -= 1;
        _cartList[objIndex]['amount'] -= _intitialList[objIndex].amount;
        calculateSumInCart();
      }
      print('list$_cartList');

      notifyListeners();
    } else {
      _calculatedAmount = 0;
      notifyListeners();
    }
  }

  addCartPrice(int objIndex) {
    _cartList[objIndex]['quantity'] += 1;
    _cartList[objIndex]['amount'] += _intitialList[objIndex].amount;
    calculateSumInCart();
    notifyListeners();
  }

  removeItemFromList(String id) {
    if (_cartList.isNotEmpty) {
      _cartList.removeWhere((element) => element['id'] == id);
      calculateSumInCart();
    }
    notifyListeners();
  }

  calculateSumInCart() {
    _calculatedAmount =
        _cartList.map((item) => item['amount'] ?? 0).reduce((a, b) => a + b);
  }

  setCartList(Map<String, dynamic> cartItems) {
    List<CartModel> cartModel =
        (_cartList).map((e) => CartModel.fromJson(e)).toList();
    CartModel items = CartModel.fromJson(cartItems);
    var existing =
        cartModel.where((itemToCheck) => itemToCheck.id == items.id).length;
    if (existing > 0) {
      debugPrint('already in list');
    } else {
      _cartList.add(cartItems);
      _newCartList.add(
          {"quantity": cartItems["quantity"], "productId": cartItems["id"]});
      print('cartlist:${_cartList}');
      print('newCartList:${_newCartList}');
      _intitialList.add(items);
      print('_cartList:$_cartList');
    }
  }

  setNewAddressList(Map<String, String> addressItems) {
    _addressList.add(addressItems);
    print('list: $addressList');
    notifyListeners();
  }

  // Get Order History.
  Future<List<dynamic>> getAddress(
    BuildContext context,
  ) async {
    try {
      var data = await _helper.getAddress(AuthMixin.auth(context).token!);

      print('messages: $data');
      setAddresses(data['data']);
      notifyListeners();

      //Return result
      return data['data'];
    } catch (ex) {
      ///7. Throw exceptions
      throw ApiFailureException(ex);
    }
  }

  ///2. Forgot password
  Future<dynamic> addAddress(String address, BuildContext context) async {
    try {
      ///1. Set Loading state to true
      setIsLoading(true);
      notifyListeners();

      // ///2.Call ADD ADDRESS
      await _helper.addAddress(address, AuthMixin.auth(context).token!);

      ///3.Set Loading state to false
      setIsLoading(false);
      notifyListeners();
      showFlush(context, 'Successfully added address');
      await getAddress(context);
      popView(context);
    } catch (ex) {
      ///5.Set Loading state to false
      setIsLoading(false);
      notifyListeners();
      showFlush(context, ex.toString());

      print('ex: ${ex.toString()}');
    }
  }

  //Set price
  setPrice(int price) {
    _quantity = price;
    notifyListeners();
  }

  //Add price by 1
  addPrice() {
    _quantity += 1;
    notifyListeners();
  }

  //Reduce price by 1
  reducePrice() {
    if (_quantity > 1) {
      _quantity -= 1;
    }
    notifyListeners();
  }

  //Set amount 1
  setAmount(int amount) {
    _amount = amount;
  }

  //Increase amount
  increaseAmount(int newAmount) {
    _amount = amount + newAmount;
    notifyListeners();
  }

  //Reduce amount
  reduceAmount(int newAmount) {
    if (amount > newAmount) {
      _amount = amount - newAmount;
      notifyListeners();
      print('amuunt: $_amount');
    }
  }

  // Get Order History.
  Future<List<OrderHistoryModel>> getOrderHistory(
    BuildContext context,
  ) async {
    try {
      var data = await _helper.fetchOrders(AuthMixin.auth(context).token!);

      print('messages: $data');
      final result =
          (data as List).map((e) => OrderHistoryModel.fromJson(e)).toList();

      setOrderHistory(result);
      notifyListeners();

      //Return result
      return result;
    } catch (ex) {
      ///7. Throw exceptions
      throw ApiFailureException(ex);
    }
  }

  // Get Products
  Future<List<ProductModel>> getProducts(
    BuildContext context,
  ) async {
    try {
      var data = await _helper.fetchProducts(AuthMixin.auth(context).token!);

      print('ProductModel: $data');
      final result = (data['data']['products'] as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      setProducts(result);
      notifyListeners();

      //Return result
      return result;
    } catch (ex) {
      ///7. Throw exceptions
      throw ApiFailureException(ex);
    }
  }

  // Get Payment Options
  // Future<List<PaymentOptions>> getPaymentOptions(
  Future<dynamic> getPaymentOptions(
    BuildContext context,
  ) async {
    try {
      // setIsLoading(true);
      // notifyListeners();

      // var data =
      //     await _helper.getPaymentOptions(AuthMixin.auth(context).token!);
      // setIsLoading(false);
      // notifyListeners();
      // final result =
      //     (data as List).map((e) => PaymentOptions.fromJson(e)).toList();
      //
      // setPaymentOptions(result);
      // notifyListeners();

      openDialog(context, const StorePopUp());

      //Return result
      // return result;
    } catch (ex) {
      setIsLoading(false);
      notifyListeners();

      ///7. Throw exceptions
      throw ApiFailureException(ex);
    }
  }

  // Get Payment Options
  Future<List<dynamic>> checkOut(
    BuildContext context,
    int id,
  ) async {
    try {
      setIsLoading(true);
      notifyListeners();

      var data = await _helper.checkOut(AuthMixin.auth(context).token!,
          newCartList, paymentOptions[id].id.toString());
      setIsLoading(false);
      notifyListeners();

      navigate(
          context,
          AccountCreated(
            onPressed: () => const AppLayout(),
            mainText: 'Transaction Successful',
            buttonText: 'MAKE ANOTHER PURCHASE',
            fabText: 'Go to Dashboard Instead',
            showFab: true,
          ));
      //Return result
      return data;
    } catch (ex) {
      setIsLoading(false);
      notifyListeners();

      ///7. Throw exceptions
      throw ApiFailureException(ex);
    }
  }

  static CartMixin cartProvider(BuildContext context, {bool listen = false}) {
    _context = context;
    return Provider.of<CartMixin>(context, listen: listen);
  }
}
