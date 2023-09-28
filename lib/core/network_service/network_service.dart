import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../config/flavors/flavors.dart';
import '../../module/auth/repo/auth_repository.dart';
import '../core.dart';

class NetworkService {
  final Dio dio;
  final Flavors flavors;

  NetworkService(this.flavors, {required this.dio}) {
    dio
      ..options.baseUrl = flavors.config.baseUrl
      ..options.connectTimeout = const Duration(seconds: 18)
      ..options.receiveTimeout = const Duration(seconds: 18)
      ..options.sendTimeout = const Duration(seconds: 18)
      ..options.responseType = ResponseType.json;
    // enable network_service interceptor for logs in debug mode
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(
        request: false,
        requestHeader: false,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
      ));
    }
    log(" 'DIO' configured with baseUrl ${flavors.config.baseUrl} ✓");
  }

  ///  GET API METHOD
  Future<dynamic> get(
      String url, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    print('Headers while getting user profile ${sl<AuthRepository>().getHeaders()}');
    try {
      var response = await dio.get(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: sl<AuthRepository>().getHeaders()),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioException catch (error) {
      throw BaseFailure.handleFailure(error);
    } on FormatException catch (_) {
      throw const FormatException("BAD FORMAT, Unable to process the data");
    } catch (e) {
      log('DEFAULT CATCH EXCEPTION IN POST METHOD [NetworkApService] :: $e');
    }
  }

  ///  POST API METHOD
  Future<dynamic> post(
      String url, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: sl<AuthRepository>().getHeaders(),),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
    } on DioException catch (error) {
      throw BaseFailure.handleFailure(error);
    } on FormatException catch (_) {
      throw const FormatException("BAD FORMAT, Unable to process the data");
    } catch (e) {
      log('DEFAULT CATCH EXCEPTION IN POST METHOD [NetworkApService] :: $e');
    }
  }
}
