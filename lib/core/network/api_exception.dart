import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException(this.message, {this.statusCode, this.data});

  factory ApiException.fromDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException();
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final responseData = error.response?.data;

        if (statusCode == 401) {
          final msg = responseData is Map
              ? (responseData['message'] ?? responseData['error'] ?? 'Unauthorized')
              : 'Session expired or unauthorized. Please log in again.';
          return UnauthorizedException(msg.toString());
        }

        final msg = responseData is Map
            ? (responseData['message'] ??
                responseData['detail'] ??
                responseData['error'] ??
                'Request failed with status $statusCode')
            : (error.message ?? 'Server error ($statusCode)');
        return ApiException(msg.toString(), statusCode: statusCode, data: responseData);
      case DioExceptionType.cancel:
        return const ApiException('Request was cancelled');
      default:
        return ApiException(error.message ?? 'An unexpected network error occurred');
    }
  }

  @override
  String toString() => message;
}

class NetworkException extends ApiException {
  const NetworkException([
    super.message = "Network connection failed. Please check your internet connection.",
  ]);
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException([
    super.message = "Session expired or unauthorized. Please log in again.",
  ]) : super(statusCode: 401);
}
