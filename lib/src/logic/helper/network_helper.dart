import 'dart:convert';
import 'dart:io';

import 'package:engagementwallet/src/logic/exceptions/api_failure_exception.dart';
import 'package:engagementwallet/src/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

/// Helper class to make http request

uriConverter(String url) {
  return Uri.https(kUrl, url);
}

uriConverterWithQuery(String url, Map<String, dynamic> params) {
  return Uri.https(kUrl, url, params);
}

class NetworkHelper {
  //Login example
  Future<dynamic> loginUser(
      String email, String? password, BuildContext context) async {
    var body = {
      "userName": email,
      "password": password == null || password == '' ? 'string' : password,
      "isBiometrics": true
    };

    return await postRequest(body: body, url: 'api/auth/login');
  }

  ///forgot password
  Future<dynamic> forgotPassword(String email) async {
    print('hi');
    var params = {
      "phoneOrEmail": email,
      "verificationPurpose": 'PasswordReset'
    };

    return await postParamRequest(
      'api/auth/start-customer-verification',
      params,
    );
  }

  ///uploadFile example
  Future<dynamic> updateCustomerProfile(
      File image,
      String email,
      String firstName,
      String lastName,
      String phone,
      String password,
      String userId,
      String? token) async {
    var stream = http.ByteStream(image.openRead());

    // Cast stream
    stream.cast();

    // get file length
    var length = await image.length();

    //Request Multipart
    var request = http.MultipartRequest(
        "PATCH", uriConverter('api/auth/update-customer-profile'));

    request.fields['emailAddress'] = email;
    request.fields['firstName'] = firstName;
    request.fields['lastName'] = lastName;
    request.fields['phoneNumber'] = phone;
    request.fields['password'] = password;
    request.fields['userId'] = userId;

    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(image.path), contentType: MediaType('image', 'png'));
    request.files.add(multipartFile);
    request.headers.addAll(kHeaders(token));
    http.StreamedResponse response = await request.send();
    final respStr = await response.stream.bytesToString();
    var decoded = jsonDecode(respStr);
    if (response.statusCode == 200) {
      print('url: ${decoded['data']}');
      return decoded['data'];
    } else {
      print(decoded);
      throw ApiFailureException(decoded['message']);
    }
  }

  ///forgot password
  Future<dynamic> addAddress(String deliveryAddress) async {
    print('hi');
    var params = {
      "deliveryAddress": deliveryAddress,
    };

    return await postParamRequest(
      'api/auth/add-address',
      params,
    );
  }
  // //Update Customer Profile
  // Future<dynamic> updateCustomerProfile(
  //     String email,
  //     String firstName,
  //     String lastName,
  //     String phone,
  //     String password,
  //     String userId,
  //     String image,
  //     BuildContext context) async {
  //   var body = {
  //     "emailAddress": email,
  //     "firstName": firstName,
  //     "lastName": lastName,
  //     "phoneNumber": phone,
  //     "password": password,
  //     "userId": userId,
  //     // "profileImage": base64Image
  //     "profileImage": 'data:image/png;base64,$image'
  //   };
  //
  //   print('body: $body');
  //   return await patchRequest('api/auth/update-customer-profile', body);
  // }

  //verifyCustomerOtp example
  Future<dynamic> startCustomerVerification(
      String phoneNumber, String verificationPurpose) async {
    var params = {
      "phoneOrEmail": '+234${phoneNumber}',
      "verificationPurpose": verificationPurpose
    };

    return await postParamRequest(
        'api/auth/start-customer-verification', params);
  }

  //verifyCustomerOtp example
  Future<dynamic> verifyCustomerOtp(
      String phoneNumber, String code, String verificationPurpose) async {
    var params = {
      "phoneOrEmail": '+234${phoneNumber}',
      "code": code,
      "verificationPurpose": verificationPurpose
    };

    return await postParamRequest('api/auth/verify-customer-otp-code', params);
  }

  //Verify Otp
  Future<dynamic> logout(String token) async {
    return await putRequest('api/auth/logout', null, token);
  }

  //Forgot Password
  Future<dynamic> changePassword(String confirmPassword, String newPassword,
      String currentPassword, String token) async {
    var body = {
      "currentPassword": currentPassword,
      "newPassword": newPassword,
      "confirmNewPassword": confirmPassword
    };
    return await postRequest(
        url: 'api/auth/change-admin-password', body: body, token: token);
  }

  //Forgot Password
  Future<dynamic> resetPassword(
    String email,
    String token,
    String password,
    String newPassword,
  ) async {
    var body = {
      "email": email,
      "token": token,
      "password": password,
      "confirmPassword": newPassword
    };
    return await postRequest(
        url: 'api/auth/reset-password', body: body, token: token);
  }

  Future<dynamic> createPin(
    String pin,
  ) async {
    var body = {
      "pin": pin,
    };
    return await postRequest(
        url: 'api/auth/create-pin', body: body, token: null);
  }

  //Verify Otp
  Future<dynamic> verifyOTP(String otp, String token) async {
    var body = {"otp": otp};
    return await putRequest('api/auth/verify', body, token);
  }

  //Sign Up Resend otp
  Future<dynamic> sendOTP(String token) async {
    var params = {"mode": "customer"};

    return await putParamRequest('api/auth/resend_otp', params, token);
  }

  //Forgot Password
  Future<dynamic> sendOTPAnon(String email) async {
    var params = {"mode": "customer", "email": email};

    return await putParamRequest('api/auth/resend_otp_anon', params, "");
  }

  ///Get User
  Future<dynamic> getUser(String? token) async {
    return await getRequest(url: 'customer/profile', token: token);
  }

  ///Edit User Profile
  Future<dynamic> editProfile(String token, String firstName, String lastName,
      String phoneNumber, String profilePicture, int age, String gender) async {
    Map<String, dynamic> body = {
      "firstName": firstName,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
      "profileImage": profilePicture,
      "age": age.toString(),
      "gender": gender.toLowerCase()
    };

    print('body: $body');

    return await putRequest('customer/profile', body, token);
  }

  //Update Customer Profile
  Future<dynamic> acceptFriendRequest(
      String requestUserId, bool value, String token) async {
    var body = {
      "requestUserId": requestUserId,
      "accepted": value.toString(),
    };

    print('body: $body');
    return await patchRequest('api/auth/accept-friend-request', body, token);
  }

  ///Add friends
  Future<dynamic> addFriends(String? token, String? userId) async {
    var params = {"requestUserId": userId};

    return await postParamRequest('api/auth/add-friends', params, token!);
  }

  ///Search friends
  Future<dynamic> searchFriends(String? token, String? name) async {
    var params = {"name": name};

    return await getParamRequest(
        url: 'api/auth/search-friends', params: params, token: token!);
  }

  ///Search friends
  Future<dynamic> getFriendList(String? token) async {
    return await getRequest(
        url: 'api/auth/get-unaccept-friend-request', token: token!);
  }

  ///Get Orders
  Future<dynamic> fetchOrders(String? token) async {
    return await getRequest(url: 'api/order/get-orders', token: token);
  }

  ///Get Orders
  Future<dynamic> fetchProducts(String? token) async {
    return await getRequest(url: 'api/product/products', token: token);
  }

  ///Get Orders
  Future<dynamic> getPaymentOptions(String? token) async {
    return await getRequest(
        url: 'api/purcahse/get-all-payment-options', token: token);
  }

  ///Get Orders
  Future<dynamic> getAddress(String? token) async {
    return await getRequest(url: 'api/auth/get-all-addresses', token: token);
  }

  ///Checkout
  Future<dynamic> checkOut(String token, List<Map<String, dynamic>> cartList,
      String paymentId) async {
    Map<String, dynamic> body = {
      "cartReq": cartList,
      "paymentOptionId": paymentId,
    };

    print('token: $token');

    print('body: $body');

    return await postRequest(
        url: 'api/purcahse/check-out', body: body, token: token);
  }

  ///Get Mostly Viewed Courses
  Future<dynamic> fetchMostlyViewedCourses(String? token) async {
    return await getRequest(url: 'course/most-viewed', token: token);
  }

  ///Get Customer Courses
  Future<dynamic> fetchCustomerCourses(String? token, String? param) async {
    var params = {"query": param ?? ''};

    return await getParamRequest(
        url: 'customer/course', params: params, token: token!);
  }

  ///Get Customer Courses with Id
  Future<dynamic> fetchCustomerCoursesId(String? token, String id) async {
    return await getRequest(url: 'customer/course/$id', token: token);
  }

  //Get Free Courses
  Future<dynamic> getFreeCourses(String? token) async {
    var params = {"free": "true"};
    return await getParamRequest(
        url: 'customer/session', params: params, token: token!);
  }

//Watch Free Courses
  Future<dynamic> watchFreeCourses(String? token, String? lessonId) async {
    return await getRequest(
        url: 'customer/course/session/$lessonId/join', token: token);
  }

  //Buy Course
  Future<dynamic> applyVoucher(
      String courseId, String? discountId, String token) async {
    var params = {"courseId": courseId};

    return await getParamRequest(
        url: 'customer/discount/course/find/$discountId',
        params: params,
        token: token);
  }

  //Buy Course
  Future<dynamic> buyCourse(
      String courseId, String? discountId, String token) async {
    var body = {"discountCode": discountId ?? ''};

    return await putRequest('customer/course/$courseId/buy', body, token);
  }

  //Own Course
  Future<dynamic> ownCourse(String courseId, String token) async {
    return await getRequest(url: 'course/$courseId/own', token: token);
  }

  //Get Free Courses
  Future<dynamic> getExploreCategories() async {
    return await getRequest(url: 'course/category', token: "");
  }

  //Get Free Courses
  Future<dynamic> getNotifications(String token) async {
    return await getRequest(url: 'notification', token: token);
  }

  Future<dynamic> getExploreCourses(String key) async {
    var params = {"key": "$key"};
    return await getParamRequest(
      url: 'course',
      params: params,
      token: '',
    );
  }

  //GET POST PUT
  Future<dynamic> getParamRequest(
      {String? url,
      Map<String, dynamic>? params,
      required String token,
      BuildContext? context}) async {
    var response = await http.get(uriConverterWithQuery(url!, params!),
        headers: kHeaders(token));
    print('urlll: ${uriConverterWithQuery(url, params)}');
    print(response.body);
    var decoded = jsonDecode(response.body);
    print(response.headers);
    if (response.statusCode.toString().startsWith('2')) {
      return decoded;
    } else {
      throw ApiFailureException(decoded['error']);
    }
  }

  Future<dynamic> postParamRequest(String? url, Map<String, dynamic>? params,
      [String? token, Map? body]) async {
    print('urlll:${uriConverterWithQuery(url!, params!)}');
    var response = await http.post(uriConverterWithQuery(url, params),
        headers: kHeaders(token ?? null),
        body: body != null ? json.encode(body) : null);
    var decoded = jsonDecode(response.body);
    print(response.headers);
    if (response.statusCode.toString().startsWith('2')) {
      return decoded;
    } else {
      throw ApiFailureException(decoded['error']);
    }
  }

  Future<dynamic> putParamRequest(String? url, Map<String, dynamic>? params,
      [String? token, Map? body]) async {
    print('urlll:${uriConverterWithQuery(url!, params!)}');
    var response = await http.put(uriConverterWithQuery(url, params),
        headers: kHeaders(token ?? null),
        body: body != null ? json.encode(body) : null);
    var decoded = jsonDecode(response.body);
    print(response.headers);
    if (response.statusCode.toString().startsWith('2')) {
      return decoded;
    } else {
      throw ApiFailureException(decoded['error']);
    }
  }

  Future<dynamic> getRequest({String? url, String? token}) async {
    // print('courseID:${courseId}');
    print('url: ${uriConverter(url!)}');
    print('token: ${token}');
    var response = await http.get(uriConverter(url), headers: kHeaders(token));
    print('response-body: ${response.body}');
    var decoded = jsonDecode(response.body);
    print(response.headers);
    print(response.statusCode);
    if (response.statusCode.toString().startsWith('2')) {
      return decoded;
    } else {
      throw ApiFailureException(decoded['error']);
    }
  }

  Future<dynamic> putRequest(String? url, [Map? body, dynamic token]) async {
    var response = await http.put(uriConverter(url!),
        body: json.encode(body ?? null), headers: kHeaders(token ?? null));
    var decoded = jsonDecode(response.body);
    print('decode:${response.statusCode}');
    if (response.statusCode.toString().startsWith('2')) {
      print('decode:$decoded');
      return decoded;
    } else {
      print('decode:${response.body}');
      debugPrint(
          'reason is ${response.reasonPhrase} message is ${decoded['error']}');
      throw ApiFailureException(decoded['error']);
    }
  }

  Future<dynamic> patchRequest(String? url, [Map? body, dynamic token]) async {
    print('url: ${uriConverter(url!)}');
    var response = await http.patch(uriConverter(url),
        body: json.encode(body ?? null), headers: kHeaders(token ?? null));
    var decoded = jsonDecode(response.body);
    print('decode:${response.statusCode}');
    if (response.statusCode.toString().startsWith('2')) {
      print('decode:$decoded');
      return decoded;
    } else {
      print('decode:${response.body}');
      debugPrint(
          'reason is ${response.reasonPhrase} message is ${decoded['error']}');
      throw ApiFailureException(decoded['error']);
    }
  }

  Future<dynamic> postRequest({
    Map? body,
    required String url,
    String? token,
  }) async {
    print('decoded: ${uriConverter(url)}');
    print('decoded: ${body}');

    var response = await http.post(uriConverter(url),
        headers: kHeaders(token ?? null), body: json.encode(body ?? null));
    print('Status code: ${response.statusCode}');

    var decoded = jsonDecode(response.body);
    if (response.statusCode.toString().startsWith('2')) {
      print('decoded: $decoded');

      return decoded;
    } else {
      print('decoded: $decoded');
      debugPrint(
          'reason is ${response.reasonPhrase} message is ${decoded['error']}');
      throw ApiFailureException(decoded['error']);
    }
  }
}
