import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:monuite/helpers/models/addresses/address_book_nodel.dart';
import 'package:monuite/helpers/models/addresses/address_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/common/constants.dart';
import '../helpers/models/common/response_model.dart';
import '../helpers/models/user.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _refreshToken;
  DateTime? _expiryDate;
  User? _user;
  List<AddressBookModel> _addressBook = [];
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  User? get currentUser {
    return _user;
  }

  List<AddressBookModel> get addressBook {
    return _addressBook;
  }

  String get userName {
    String username = '';
    if (_user != null) {
      username = _user!.firstName!;
      if (_user!.lastName != null && _user!.lastName!.isNotEmpty) {
        username += ' ${_user!.lastName}';
      }
    }
    return username;
  }

  String? get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<String> _authenticate(
    String email,
    String password,
  ) async {
    final url = Uri.parse('${Constants.baseUrl}auth/login');
    // final loginInfo = 'UserName=$email&Password=$password&grant_type=password';
    // final base64Str = Utility.convertStringToBase64String(
    //     '${Constants.clientID}:${Constants.clientSecret}');
    try {
      final Response? response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'userName': email, 'password': password}),
      );
      if (response != null) {
        final responseData = json.decode(response.body);
        if (responseData['error'] != null) {
          var error = responseData['error_description'];
          return error;
        }
        _token = responseData['token'];

        final userObj = responseData['user'];
        _user = User.fromJson(userObj);

        final expiry = responseData['expiry'];
        _expiryDate = expiry != null
            ? DateTime.parse(expiry)
            : DateTime.now().add(Duration(days: 1));

        _autoLogout();
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({
          'token': _token,
          // 'refresh_token': _refreshToken,
          'user': jsonEncode(_user!.toJson()),
          'expiryDate': _expiryDate!.toIso8601String(),
        });
        prefs.setString('userData', userData);

        final addressBook = <AddressBookModel>[];
        if (userObj.shipping != null) {
          addressBook.add(AddressBookModel(
            isDefault: true,
            address: AddressModel.fromJson(userObj.shipping),
          ));
        }
        if (userObj.billing != null) {
          addressBook.add(AddressBookModel(
            isDefault: false,
            address: AddressModel.fromJson(userObj.billing),
          ));
        }
        _addressBook = addressBook;
        prefs.setString('addressBook', jsonEncode(addressBook));
      }
      return '';
    } catch (error) {
      throw error;
    }
  }

  Future<String> login(String email, String password) async {
    return _authenticate(
      email,
      password,
    );
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')!);
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    _token = extractedUserData['token'];
    _refreshToken = extractedUserData['refresh_token'];
    _user = User.fromJson(jsonDecode(extractedUserData['user']));

    _expiryDate = expiryDate;
    if (expiryDate.isBefore(DateTime.now())) {
      await refreshToken();
      // notifyListeners();
      return true;
    }
    notifyListeners();
    _autoLogout();
    return true;
  }

  void logout() async {
    _token = null;
    _user = null;
    _addressBook = [];
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  Future<void> refreshToken() async {
    final url = Uri.parse('${Constants.baseUrl}token');
    final loginInfo = 'refresh_token=$_refreshToken&grant_type=refresh_token';
    final base64Str = Utility.convertStringToBase64String(
        '${Constants.clientID}:${Constants.clientSecret}');
    try {
      final Response? response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic $base64Str'
        },
        body: loginInfo,
      );
      if (response != null) {
        final responseData = json.decode(response.body);
        if (responseData['error'] != null) {
          var error = responseData['error_description'];
          return error;
        }
        _token = responseData['access_token'];
        _refreshToken = responseData['refresh_token'];

        final userObj = json.decode(responseData['userobj']);
        _user = User.fromJson(userObj);

        final expiryInSeconds = responseData['expires_in'];
        _expiryDate = DateTime.now().add(Duration(
          seconds: expiryInSeconds,
        ));
        _autoLogout();
        // notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({
          'token': _token,
          'refresh_token': _refreshToken,
          'user': jsonEncode(_user),
          'expiryDate': _expiryDate!.toIso8601String(),
        });
        prefs.setString('userData', userData);
      }
      return;
    } catch (error) {
      throw error;
    }
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), refreshToken);
  }

  Future<String> updateDuty(
    String id,
    bool onDuty,
  ) async {
    final url = Uri.parse(
        '${Constants.baseUrl}driver/${onDuty ? 'on-duty' : 'off-duty'}/$id');
    try {
      final Response? response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
        },
      );
      if (response != null) {
        final responseData = json.decode(response.body);
        ResponseModel<String> result =
            ResponseModel<String>.fromJson(responseData);
        if (result.hasError) {
          var error = result.msg;
          return error ?? 'Error';
        }

        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({
          'token': _token,
          'refresh_token': _refreshToken,
          'user': jsonEncode(_user),
          'expiryDate': _expiryDate!.toIso8601String(),
        });
        prefs.setString('userData', userData);
        notifyListeners();
      }
      return '';
    } catch (error) {
      throw error;
    }
  }

  Future<User?> refreshUserData() async {
    final url = Uri.parse('${Constants.baseUrl}user/get-current-user');
    try {
      final Response? response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
        },
      );
      if (response != null) {
        final userObj = json.decode(response.body);
        _user = User.fromJson(userObj);

        final prefs = await SharedPreferences.getInstance();
        final userData = json.encode({
          'token': _token,
          'refresh_token': _refreshToken,
          'user': jsonEncode(_user),
          'expiryDate': _expiryDate!.toIso8601String(),
        });
        prefs.setString('userData', userData);

        final addressBook = <AddressBookModel>[];
        if (userObj.shipping != null) {
          addressBook.add(AddressBookModel(
            isDefault: true,
            address: AddressModel.fromJson(userObj.shipping),
          ));
        }
        if (userObj.billing != null) {
          addressBook.add(AddressBookModel(
            isDefault: false,
            address: AddressModel.fromJson(userObj.billing),
          ));
        }
        _addressBook = addressBook;
        prefs.setString('addressBook', jsonEncode(addressBook));

        return _user;
      }
      return null;
    } catch (error) {
      throw error;
    }
  }

  Future<String> registerPrivate(
    String email,
    String password,
    String telephone,
  ) async {
    return _registerPrivate(
      email,
      password,
      telephone,
    );
  }

  Future<String> _registerPrivate(
    String email,
    String password,
    String telephone,
  ) async {
    final url = Uri.parse('${Constants.baseUrl}auth/register-private');
    try {
      final Response? response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'telephone': telephone
        }),
      );
      if (response != null) {
        final responseData = json.decode(response.body);
        ResponseModel<String> result = ResponseModel.fromJson(responseData);
        if (result.hasError) {
          return Future.value(result.msg);
        }

        return _authenticate(email, password);
      }
      return '';
    } catch (error) {
      throw error;
    }
  }

  Future<String> registerCorporate(
    String firstName,
    String lastName,
    String companyName,
    String email,
    String password,
    String telephone,
    String message,
  ) async {
    return _registerCorporate(
      firstName,
      lastName,
      companyName,
      email,
      password,
      telephone,
      message,
    );
  }

  Future<String> _registerCorporate(
    String firstName,
    String lastName,
    String companyName,
    String email,
    String password,
    String telephone,
    String message,
  ) async {
    final url = Uri.parse('${Constants.baseUrl}auth/register-corporate');
    try {
      final Response? response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstName': firstName,
          'lastName': lastName,
          'companyName': companyName,
          'email': email,
          'password': password,
          'telephone': telephone,
          'message': message,
        }),
      );
      if (response != null) {
        final responseData = json.decode(response.body);
        if (responseData['error'] != null) {
          var error = responseData['error_description'];
          return error;
        }

        return _authenticate(email, password);
      }
      return '';
    } catch (error) {
      throw error;
    }
  }

  Future<void> addAddress(AddressModel address) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // final addressBookStr = prefs.getString('addressBook');
      // if (addressBookStr == null || addressBookStr.isEmpty) {
      //   _addressBook = [];
      // } else {
      //   final List<dynamic> addressList = json.decode(addressBookStr);
      //   _addressBook = addressList
      //       .map((address) => AddressBookModel.fromJson(address))
      //       .toList();
      // }

      _addressBook = Utility.getAddressBook(prefs);

      // if (!_addressBook.isEmpty) {
      //   _addressBook.forEach((element) {
      //     element.isDefault = false;
      //   });
      // }

      _addressBook.add(AddressBookModel(
        isDefault: _addressBook.isEmpty,
        address: address,
      ));

      // if (_user == null) {
      //   _user!.shipping =
      //       _addressBook.where((element) => element.isDefault).first.address;
      // }

      final addressBookJson = json.encode(_addressBook);
      prefs.setString('addressBook', addressBookJson);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
