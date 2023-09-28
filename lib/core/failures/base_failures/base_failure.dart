import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../failures.dart';

/// We will have class that can implement exceptions
class BaseFailure implements Exception {
  final String message;

  const BaseFailure([this.message = 'Something went wrong, Please try again']);

  /// Exceptions on status codes ///
  static BaseFailure handleFailure(DioException dioException) {
    if (dioException.response != null) {
      log('CUSTOM CLASS DIO ERROR IS :: ${dioException.response?.data}');
      switch (dioException.response?.statusCode) {
        case 401:
          return UnauthorizedException(dioException.response?.data['message']);
        case 403:
          return ServerFailure('Authorization failed');
        case 404:
          return ServerFailure('404 - pages/resource not found');
        case 500:
          return ServerFailure('Internal Server Error, Please try again');
        case 503:
          return ServerFailure('Service unavailable, Please try again');
        default:
          return ServerFailure(dioException.response?.data['message']);
      }
    }

    /// Exception on socket/no internet
    else if (dioException.type == DioExceptionType.unknown && dioException.error is SocketException) {
      return NoInternetFailure();
    }

    /// Exceptions on timeout
    else if (dioException.type == DioExceptionType.connectionTimeout ||
        dioException.type == DioExceptionType.sendTimeout ||
        dioException.type == DioExceptionType.receiveTimeout) {
      return ConnectionFailure('Connection timeout, Please try again');
    }

    /// Exception default case
    else {
      return LowPriorityException();
    }
  }
}
