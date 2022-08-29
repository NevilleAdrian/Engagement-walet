import 'dart:convert';


import 'package:engagementwallet/src/logic/helper/network_helper.dart';
import 'package:engagementwallet/src/logic/models/app_model/app_model.dart';
import 'package:engagementwallet/src/logic/repository/hive_repository.dart';
import 'package:engagementwallet/src/ui/app_layout/app_layout.dart';
import 'package:engagementwallet/src/ui/authentication/login/login.dart';
import 'package:engagementwallet/src/ui/authentication/signup/account_created.dart';
import 'package:engagementwallet/src/ui/authentication/signup/complete_profile.dart';
import 'package:engagementwallet/src/ui/authentication/signup/setup_complete.dart';
import 'package:engagementwallet/src/utils/constants.dart';
import 'package:engagementwallet/src/utils/functions.dart';
import 'package:engagementwallet/src/utils/navigationWidget.dart';
import 'package:engagementwallet/src/widgets/dialogs/dialogs.dart';
import 'package:engagementwallet/src/widgets/pin_widgets/create_pin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class AuthMixin extends ChangeNotifier {
  //Build Context
  static BuildContext? _context;

  //Constructor
  AuthMixin(this._helper, this._hiveRepository);


  final NetworkHelper _helper;
  final HiveRepository _hiveRepository;


  //Initializers
  bool _isLoading = false;
  String? _token;
  String? _phone;
  String? _otp;
  String? _userId;
  String? _image;


  //Getters
  bool get isLoading => _isLoading;
  String? get token => _token;
  String? get phone => _phone;
  String? get otp => _otp;
  String? get userId => _userId;
  String? get image => _image;


  //Setters
  setIsLoading(bool isLoading) => _isLoading = isLoading;
  setToken(String? token) => _token = token;
  setPhone(String? phone) => _phone = phone;
  setOtp(String? otp) => _otp = otp;
  setUserId(String? userId) => _userId = userId;
  setImage(String? image) {
    _image = image;
    notifyListeners();
  }



  //AuthProvider abstraction
  static AuthMixin auth(BuildContext context, {bool listen = false}) {
    _context = context;
    return Provider.of<AuthMixin>(context, listen: listen);
  }


  ///1.Login
  Future<dynamic> loginUser(String emailAddress, String password, BuildContext context) async {
    try {
      ///1. Set Loading state to true
      setIsLoading(true);
      notifyListeners();

      ///2. Login user
      var data = await _helper.loginUser(emailAddress, password, _context!);

      ///3. Save token
      setToken(data['data']['accessToken']);

      print('decoded: ${parseJwtPayLoad(data['data']['accessToken'])}');

      // setDecoded(DecodedToken.fromJson(parseJwtPayLoad(data['data']['accessToken'])));


      ///4a. Print token
      print('token:$token');

      ///4b. Save Token in hive
      _hiveRepository.add<AppModel>(name: kTokenName, key: 'token', item: AppModel(token: token));

      navigate(
        context,
        const AppLayout(),
      );

      ///3.Set Loading state to false
      setIsLoading(false);
      notifyListeners();


    } catch (ex) {
      ///7.Set Loading state to false
      setIsLoading(false);
      notifyListeners();
      showFlush(context, ex.toString());


    }
  }

  ///2.Sign up
  Future<dynamic> updateCustomerProfile(
      {String? email,
        String? password,
        String? firstName,
        String? lastName,
        String? image,
        BuildContext? context}) async {
    try {
      ///1. Set Loading state to true
      setIsLoading(true);
      notifyListeners();

      ///2. Sign up user
      var data = await _helper.updateCustomerProfile(
        email!,
        firstName!,
        lastName!,
        _phone!,
        password!,
        userId!,
        image!,
        context!
      );
      
      print('data: $data');

      ///3.Set Loading state to false
      setIsLoading(false);
      notifyListeners();

      await openDialog(context, const CreatePin());


    } catch (ex) {
      ///4.Set Loading state to false
      print('ex: ${ex.toString()}');
      setIsLoading(false);
      notifyListeners();
    }
  }


  ///3.Start Verification
  Future<dynamic> startCustomerVerification({String? phoneNumber, String? verificationPurpose, BuildContext? context}) async {
    print('phone: ${phoneNumber}');
    if( phoneNumber == null){
      showFlush(context!, 'Please input a valid phone number');
    } else {
      try {
        ///1. Set Loading state to true
        setIsLoading(true);
        notifyListeners();

        ///2. Sign up user
        await _helper.startCustomerVerification(phoneNumber, verificationPurpose!);

        ///3.Set Loading state to false
        setIsLoading(false);
        notifyListeners();

        ///4. Set Customer OTP
        setPhone(phoneNumber);

        /// 5. await dialog
        await openDialog(context!);


      } catch (ex) {
        ///5.Set Loading state to false
        setIsLoading(false);
        notifyListeners();

        print(ex.toString());

        ///6. Show flushbar
        showFlush(context!, ex.toString());
      }
    }

  }

  ///3.Start Verification
  Future<dynamic> verifyCustomerOtp({ String? otp, String? verificationPurpose, BuildContext? context}) async {
    print('phone: ${_phone}');

      try {
        ///1. Set Loading state to true
        setIsLoading(true);
        notifyListeners();

        ///2. Sign up user
        var data = await _helper.verifyCustomerOtp(_phone!, otp!, verificationPurpose!);

        print('data: $data');


        ///3. SetUserId
        setUserId(data['data']['userId']);

        ///4.Set Loading state to false
        setIsLoading(false);
        notifyListeners();

        /// 5. await dialog
        navigate(context!,  AccountCreated(
          onPressed: () => navigate(
            context,
            const CompleteProfile(),
          ) ,
        ));


      } catch (ex) {
        ///5.Set Loading state to false
        setIsLoading(false);
        notifyListeners();

        print(ex.toString());

        ///6. Show flushbar
        showFlush(context!, ex.toString());
      }


  }

  ///4.resend Otp
  Future<dynamic> resendOtp(BuildContext context) async {
    try {
      ///1. Set Loading state to true
      setIsLoading(true);
      notifyListeners();

      ///4. Call Send otp with token endpoint
      await _helper.sendOTP(token!);

      ///5.Set Loading state to false
      setIsLoading(false);
      notifyListeners();

      ///6. Show message
      showFlush(context, "An otp has been sent to your email");

    } catch (ex) {
      ///7.Set Loading state to false
      setIsLoading(false);
      notifyListeners();

    }
  }

  ///3.resend Otp
  Future<dynamic> resendOtpAnon(BuildContext context,String email) async {
    try {
      ///1. Set Loading state to true
      setIsLoading(true);
      notifyListeners();

      ///4. Call Send otp with token endpoint
      await _helper.sendOTPAnon(email);

      ///5.Set Loading state to false
      setIsLoading(false);
      notifyListeners();

      ///6. Show message
      showFlush(context, "An otp has been sent to your email");
    } catch (ex) {
      ///7.Set Loading state to false
      setIsLoading(false);
      notifyListeners();

    }
  }

  ///3. Forgot password
  Future<dynamic> forgotPassword(String email, BuildContext context) async {
    try {
      ///1. Set Loading state to true
      setIsLoading(true);
      notifyListeners();

      ///2.Call forget Password
      await _helper.forgotPassword(email);

      ///3.Set Loading state to false
      setIsLoading(false);
      notifyListeners();

    } catch (ex) {
      ///5.Set Loading state to false
      setIsLoading(false);
      notifyListeners();

    }
  }

  ///4. Change password
  Future<dynamic> changePassword(String confirmPassword, String newPassword, String currentPassword, BuildContext context) async {
    try {
      ///1. Set Loading state to true
      setIsLoading(true);
      notifyListeners();

      print('loading: $isLoading');
      ///2.Call forget Password
      await _helper.changePassword(confirmPassword, newPassword, currentPassword, token!);

      ///3.Set Loading state to false
      setIsLoading(false);
      notifyListeners();

      ///4. SHow flushbar
      showFlush(context, 'Password Successfully Created');
      popView(context);





    } catch (ex) {
      ///5.Set Loading state to false
      setIsLoading(false);
      notifyListeners();

      print('ex: ${ex.toString()}');

      showFlush(context, ex.toString());


    }
  }

  ///5. Change password
  Future<dynamic> setPin({String? pin, BuildContext? context}) async {
    try {
      ///1. Set Loading state to true
      setIsLoading(true);
      notifyListeners();

      ///2.Call forget Password
      await _helper.createPin(pin!);

      ///3.Set Loading state to false
      setIsLoading(false);
      notifyListeners();

      navigate(context!, const SetupComplete());


    } catch (ex) {
      ///5.Set Loading state to false
      setIsLoading(false);
      notifyListeners();
      showFlush(context!, ex.toString());

    }
  }

  ///6. Verify Otp
  Future<dynamic> verifyOtp(String otp, BuildContext context,String email) async {
    try {
      ///1. Set Loading state to true
      setIsLoading(true);
      notifyListeners();

      ///2.Call forget Password
      await _helper.verifyOTP(otp, token!);

      ///3.Set Loading state to false
      setIsLoading(false);
      notifyListeners();


    } catch (ex) {
      ///5.Set Loading state to false
      setIsLoading(false);
      notifyListeners();

    }
  }




  ///6. Logout
  logout(BuildContext context, [String? route]) {

    ///1.Call logout api
    // await _helper.logout( token!);

    ///2.Clear local storage
    setToken(null);

    ///3.Clear token hive
    _hiveRepository.clear<AppModel>(name: kTokenName);


    ///4. push to login
    navigate(context, const LoginScreen());
  }

  ///7. Decode token
  Map<String, dynamic> parseJwtPayLoad(String token) {

    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }
    print('plp: $payloadMap');
    return payloadMap;
  }

  ///8. Decode base64 to String
  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }


}
