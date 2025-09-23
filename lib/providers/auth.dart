import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:monuite/helpers/common/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/common/constants.dart';
import '../helpers/models/common/response_model.dart';
import '../helpers/models/user.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _refreshToken;
  DateTime? _expiryDate;
  User? _user;
  Timer? _authTimer;

  bool get isAuth {
    return token != null;
  }

  User? get currentUser {
    return _user;
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
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
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
          return error;
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
}
