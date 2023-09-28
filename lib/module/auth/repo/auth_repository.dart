import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:goddessmembership/core/notifications/cloud_messaging_service.dart';
import 'package:goddessmembership/module/auth/cubit/auth_cubit/auth_cubit.dart';

import '../../../constants/api_endpoints.dart';
import '../../../constants/keys.dart';
import '../../../core/core.dart';
import '../models/auth_response.dart';
import '../models/user.dart';

class AuthRepository {
  final NetworkService _networkService;
  final StorageService _storageService;

  String? token;
  User _user = User.empty;

  User get user => _user;

  AuthRepository(this._networkService, this._storageService);

  Future<TokenResponse> getAuthToken(LoginInput input) async {
    try {
      FormData data = FormData.fromMap({
        "username": input.username,
        "password": input.password,
      });

      var response = await _networkService.post(Endpoints.getToken,
          data: data,
          options: Options(
            headers: {
              'Accept': 'application/json',
            },
          ));

      TokenResponse authResponse = TokenResponse.fromJson(response);
      if (response["jwt_token"] != null) {
        print(" ----- Token not null");
        token = response["jwt_token"];
        print(response["jwt_token"]);
        print("auth token " + authResponse.jwtToken);
        _saveToken(authResponse.jwtToken);
        return authResponse;
      }
      throw "Something went wrong";
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<User> signup(SignupInput input) async {
    try {
      FormData data = FormData.fromMap({
        "username": input.username,
        "firstname": input.firstname,
        "lastname": input.lastname,
        "email": input.email,
        "password": input.password,
      });

      var response = await _networkService.post(Endpoints.signup,
          data: data,
          options: Options(
            headers: {
              'Accept': 'application/json',
              'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjEsIm5hbWUiOiJzdXBlcnVzZXIiLCJpYXQiOjE2OTQ2MDM0NTUsImV4cCI6MTg1MjI4MzQ1NX0.d7QSY-6Oz46KS8qYDu3ER50gLIkgC7JgsxFAgwyPM_k',
            },
          ));

      User user = await compute(userFromJson, response);
      return user;
    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }

  Future<User> getUserProfile() async {
    try {
      var response = await _networkService.get(Endpoints.getUserProfile);

      User user = await compute(userFromJson, response);
      saveUser(user);
      return user;

    } on BaseFailure catch (_) {
      rethrow;
    } on TypeError catch (e) {
      log('TYPE error stackTrace :: ${e.stackTrace}');
      rethrow;
    }
  }
  // token
  Future<void> _saveToken(String token) async {
    await _storageService.setString(StorageKeys.token, token??"");
  }

  String _getToken() {

    return _storageService.getString(StorageKeys.token);
  }
  Future<void> saveUser(User user) async {
    this._user = user;
    final userMap = user.toJson();
    await _storageService.setString(StorageKeys.user, json.encode(userMap));
  }
  Future<void> _removeToken() async {
    await _storageService.remove(StorageKeys.token);
  }

  Map<String, dynamic>? getHeaders() {
    return _getToken() == ''
        ? null
        : {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${_getToken()}',
    };
  }

  Future<bool> isAuthenticated() async {
    return  await _getToken().isNotEmpty;
  }
  Future<void> _removeUser() async {
    await _storageService.remove(StorageKeys.user);
  }

  Future<void> getUser() async {
    final userString = _storageService.getString(StorageKeys.user);
    if (userString.isEmpty) {
      return;
    }
    final Map<String, dynamic> userMap = jsonDecode(userString);
    User user = User.fromJson(userMap);
    this._user = user;
  }

  Future<void> initUserAppSession() async {
    String userString = _storageService.getString(StorageKeys.user);
    if (userString.isEmpty) return;

    /// when app starts ...
    Map<String, dynamic> userMap = jsonDecode(userString);
    this._user = User.fromJson(userMap);
  }

  Future<void> logout() async {
    await _removeToken();
    await sl<CloudMessagingService>().deleteFcmToken();
    await _removeUser();
  }

}