import 'package:dio/dio.dart';

class LoginInput {
  final String username;
  final String password;

  LoginInput({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        "username": "development",
        "password": "FcPMl\$vUAQ)W9giXJAziBAxM",
      };

  FormData toFormData() => FormData.fromMap({
        "username": username,
        "password": password,
      });
}
