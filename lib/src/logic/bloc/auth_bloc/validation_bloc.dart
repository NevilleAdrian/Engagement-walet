import 'package:engagementwallet/src/logic/mixin/form_validators.dart';
import 'package:rxdart/rxdart.dart';


class ValidationBloc extends FormValidators {
  final _emailOnlyController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordOldController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _rcNumberController = BehaviorSubject<String>();
  final _bvnController = BehaviorSubject<String>();
  final _ninController = BehaviorSubject<String>();
  final _accNoController = BehaviorSubject<String>();
  final _firstNameController = BehaviorSubject<String>();
  final _userNameController = BehaviorSubject<String>();
  final _lastNameController = BehaviorSubject<String>();
  final _gCodeController = BehaviorSubject<String>();
  final _addressController = BehaviorSubject<String>();
  final _singleInputController = BehaviorSubject<String>();
  final _ccController = BehaviorSubject<String>();
  final _expController = BehaviorSubject<String>();
  final _cvvController = BehaviorSubject<String>();
  final _accountTypeController = BehaviorSubject<String>();

  // Add data to stream
  Stream<String> get emailOnly =>
      _emailOnlyController.transform(validateEmailOnlyBloc);

  Stream<String> get email =>
      _emailController.transform(validateEmailAndPhoneBloc);

  Stream<String> get oldPassword =>
      _passwordOldController.transform(validatePasswordBloc);

  Stream<String> get password =>
      _passwordController.transform(validatePasswordBloc);

  Stream<String> get confirmPassword =>
      _confirmPasswordController.transform(validateConfirmPasswordBloc);

  Stream<String> get phone => _phoneController.transform(validatePhoneBloc);

  Stream<String> get rcNumber =>
      _rcNumberController.transform(validateRcNumberBloc);

  Stream<String> get firstName =>
      _firstNameController.transform(validateFullNameBloc);

  Stream<String> get userName =>
      _userNameController.transform(validateFullNameBloc);

  Stream<String> get lastName =>
      _lastNameController.transform(validateFullNameBloc);

  Stream<String> get gCode => _gCodeController.transform(validateGCodeBloc);

  Stream<String> get address =>
      _addressController.transform(validateAddressBloc);

  Stream<String> get singleInput =>
      _singleInputController.transform(validateSingleInputBloc);

  Stream<String> get accNo => _accNoController.transform(validateAccNoBloc);

  Stream<String> get bvn => _bvnController.transform(validateBVNBloc);

  Stream<String> get nin => _ninController.transform(validateNINBloc);

  Stream<String> get cc => _ccController.transform(validateCCBloc);

  Stream<String> get exp => _expController.transform(validateEXPBloc);

  Stream<String> get cvv => _cvvController.transform(validateCVVBloc);

  Stream<String> get accountType =>
      _accountTypeController.transform(validateSingleInputBloc);

  Stream<bool> get submitValid =>
      CombineLatestStream.combine2(email, password, (e, p) => true)
          .asBroadcastStream();

  // change data
  Function(String) get changeEmailOnly => _emailOnlyController.sink.add;

  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changeFirstName => _firstNameController.sink.add;

  Function(String) get changeUserName => _userNameController.sink.add;

  Function(String) get changeLastName => _lastNameController.sink.add;

  Function(String) get changeBVN => _bvnController.sink.add;

  Function(String) get changeNIN => _ninController.sink.add;

  Function(String) get changeAccNo => _accNoController.sink.add;

  Function(String) get changeOldPassword => _passwordOldController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  Function(String) get changeConfirmPassword =>
      _confirmPasswordController.sink.add;

  Function(String) get changeSingleInput => _singleInputController.sink.add;

  Function(String) get changePhone => _phoneController.sink.add;

  Function(String) get changeRcNumber => _rcNumberController.sink.add;

  Function(String) get changeGCodeOnly => _gCodeController.sink.add;

  Function(String) get changeAddressOnly => _addressController.sink.add;

  Function(String) get changeCC => _ccController.sink.add;

  Function(String) get changeEXP => _expController.sink.add;

  Function(String) get changeCVV => _cvvController.sink.add;

  Function(String) get changeAccountType => _accountTypeController.sink.add;

  submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;

    print('Email is $validEmail, and password is $validPassword');
  }

  dispose() {
    _emailController.close();
    _emailOnlyController.close();
    _phoneController.close();
    _rcNumberController.close();
    _passwordController.close();
    _passwordOldController.close();
    _confirmPasswordController.close();
    _lastNameController.close();
    _firstNameController.close();
    _gCodeController.close();
    _addressController.close();
    _userNameController.close();
    _bvnController.close();
    _ninController.close();
    _accNoController.close();
    _ccController.close();
    _expController.close();
    _cvvController.close();
    _accountTypeController.close();
  }
}
