
import 'package:engagementwallet/src/logic/mixin/form_validators.dart';

class FormValidatorBloc with FormValidators {
  String? emailValidator(String? email) {
    return validateEmail(email!) ? null : "Please enter a valid email";
  }

  String? userNameValidator(String? username) {
    return validateUserName(username!) ? null : "Please enter a valid name";
  }

  String? userNameAndEmailValidator(String? username) {
    return validateUserName(username!) ? null : "Please enter a valid input";
  }

  String? accNoValidator(String? username) {
    return validateAccNo(username!)
        ? null
        : "Please enter a valid account number";
  }

  String? firstNameValidator(String? username) {
    return validateUserName(username!) ? null : "Please enter a valid name";
  }

  String? phoneValidator(String? phone) {
    return validatePhone(phone!) ? null : "Please enter a valid phone";
  }

  String? rcValidator(String? phone) {
    return validateRcNumber(phone!) ? null : "Please enter a valid RC Number";
  }

  String? passwordValidator(String? password) {
    return validatePassword(password!)
        ? null
        : "The password must be at least 6 characters.";
  }

  String? singleInputValidator(String? phone) {
    return validateSingleInput(phone!) ? null : "Field must not be empty";
  }

  String? otpTokenValidator(String? phone) {
    return validateToken(phone!) ? null : 'Invalid Token';
  }

  String? gCodeValidator(String? phone) {
    return validateGCode(phone!) ? null : 'Invalid Code';
  }

  String? creditCardNoValidator(String? phone) {
    return validateCreditCardNo(phone!) ? null : 'Invalid Card Number';
  }

  String? expiryDateValidator(String? phone) {
    return validateExpiryDate(phone!) ? null : 'Invalid Date';
  }

  String? cvvValidator(String? phone) {
    return validateCVV(phone!) ? null : 'Invalid CVV';
  }

  String? bvnValidator(String? phone) {
    return validateBVN(phone!) ? null : 'Invalid BVN';
  }

  String? ninValidator(String? phone) {
    return validateBVN(phone!) ? null : 'Invalid NIN';
  }

  String? addressValidator(String? phone) {
    return validateSingleInput(phone!) ? null : 'Invalid Address';
  }
}

final formValidatorBloc = FormValidatorBloc();
