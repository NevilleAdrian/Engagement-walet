import 'dart:async';

const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";
// const String _kMin8CharsOneLetterOneNumber =
//     r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$";
//const String _kMin6CharsOneLetterOneNumberOnSpecialCharacter =
//    r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$";
// const String _kMin6CharsOneUpperLetterOneNumberOnSpecialCharacter =
//     r"^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{6,}$";
//const String _kMin8CharsOneUpperLetterOneLowerLetterOnNumber = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$";
//const String _kMin8CharsOneUpperOneLowerOneNumberOneSpecial =
//    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
//const String _kMin8Max10OneUpperOneLowerOneNumberOneSpecial = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,10}$";

class FormValidators {
  bool validateEmail(String email) {
    final RegExp emailExp = new RegExp(_kEmailRule);
    if (email != null) email = email.trim();
    if (!emailExp.hasMatch(email) || email.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool validateUserName(String username) {
    if (username.isEmpty || username.length < 2) {
      return false;
    } else {
      return true;
    }
  }

  bool validateAccNo(String username) {
    if (username.isEmpty || username.length < 9) {
      return false;
    } else {
      return true;
    }
  }

  bool validatePhone(String phone) {
    if (phone.isEmpty || phone.length < 10) {
      return false;
    } else {
      return true;
    }
  }

  bool validateRcNumber(String phone) {
    if (phone.isEmpty || phone.length != 7) {
      return false;
    } else {
      return true;
    }
  }

  bool validatePassword(String password) {
    if (password.isEmpty || password.length < 6) {
      return false;
    } else {
      return true;
    }
  }

  bool validateSingleInput(String username) {
    if (username.isEmpty || username.length < 1) {
      return false;
    } else {
      return true;
    }
  }

  bool validateToken(String token) {
    if (token.isEmpty || token.length < 6) {
      return false;
    } else {
      return true;
    }
  }

  bool validateGCode(String token) {
    if (token.isEmpty || token.length != 6) {
      return false;
    } else {
      return true;
    }
  }

  bool validateCreditCardNo(String number) {
    if (number.isEmpty || number.length < 16) {
      return false;
    } else {
      return true;
    }
  }

  bool validateExpiryDate(String number) {
    if (number.isEmpty || number.length < 5) {
      return false;
    } else {
      return true;
    }
  }

  bool validateCVV(String number) {
    if (number.isEmpty || number.length < 3) {
      return false;
    } else {
      return true;
    }
  }

  bool validateBVN(String number) {
    if (number.isEmpty || number.length < 11) {
      return false;
    } else {
      return true;
    }
  }

  final validateEmailBloc =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp emailExp = new RegExp(_kEmailRule);
    if (emailExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid email');
    }
  });

  final validateEmailOnlyBloc =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp emailExp = new RegExp(_kEmailRule);
    if (emailExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid email');
    }
  });

  final validateEmailAndPhoneBloc =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp emailExp = new RegExp(_kEmailRule);
    if (emailExp.hasMatch(email) || email.length > 10) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid email or user name');
    }
  });

  final validateOTPBloc =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp emailExp = new RegExp(_kEmailRule);
    if (email.length > 5) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid OTP');
    }
  });

  final StreamTransformer<String, String> validatePasswordBloc =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (password, sink) {
    // final RegExp passwordExp = new RegExp(_kMin8CharsOneLetterOneNumber);

    if ((RegExp(r'[A-Za-z]').hasMatch(password)
        // &&
        //     RegExp(r'[0-9]').hasMatch(password)
        ) ||
        password.isEmpty && password.length >= 8) {
      sink.add(password);
    } else {
      sink.addError('Minimum 8 characters. Contains both letters and numbers');
    }
  });

  // final validatePasswordBloc = StreamTransformer<String, String>.fromHandlers(
  //     handleData: (password, sink) {
  //   if (password.length < 6) {
  //     sink.addError('The password must be at least 6 characters.');
  //   } else {
  //     sink.add(password);
  //   }
  // });

  final validateConfirmPasswordBloc =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (password, sink) {
    if (password.length < 8) {
      sink.addError('The password must be at least 8 characters.');
    } else {
      sink.add(password);
    }
  });

  final validatePhoneBloc = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length == 11) {
      sink.add(password);
    } else {
      sink.addError('Validating phone number, please enter 11 digits');
    }
  });

  final validateRcNumberBloc = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length == 7) {
      sink.add(password);
    } else {
      sink.addError('Validating rc number, please enter 7 digits');
    }
  });

  final validateFullNameBloc = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 1) {
      sink.add(password);
    } else {
      sink.addError('Invalid name');
    }
  });

  final validateGCodeBloc = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length == 6) {
      sink.add(password);
    } else {
      sink.addError('Invalid code');
    }
  });
  final validateAddressBloc = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 1) {
      sink.add(password);
    } else {
      sink.addError('Invalid address');
    }
  });

  final validateSingleInputBloc =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (password, sink) {
    if (password.length > 1) {
      sink.add(password);
    } else {
      sink.addError('Invalid field, please enter more than 1 characters');
    }
  });

  final validateCompanyNameBloc =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (password, sink) {
    if (password.length > 1) {
      sink.add(password);
    } else {
      sink.addError('Invalid name, please enter more than 1 characters');
    }
  });
  final validateAccNoBloc = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 8) {
      sink.add(password);
    } else {
      sink.addError('Invalid acc no, please enter more than 8 characters');
    }
  });

  final validateUserNameBloc = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 2) {
      sink.add(password);
    } else {
      sink.addError('Invalid username');
    }
  });

  final validateBVNBloc = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length == 11) {
      sink.add(password);
    } else {
      sink.addError('Invalid BVN');
    }
  });

  final validateNINBloc = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length == 11) {
      sink.add(password);
    } else {
      sink.addError('Invalid NIN');
    }
  });

  final validateCCBloc = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 16) {
      sink.add(password);
    } else {
      sink.addError('Invalid Number');
    }
  });

  final validateEXPBloc = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length == 5) {
      sink.add(password);
    } else {
      sink.addError('Invalid Expiry Date');
    }
  });

  final validateCVVBloc = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length == 3) {
      sink.add(password);
    } else {
      sink.addError('Invalid CVV');
    }
  });
}
