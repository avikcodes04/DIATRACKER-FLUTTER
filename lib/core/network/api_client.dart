import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:diatrack/core/network/api_exception.dart';
import 'package:diatrack/core/storage/storage_service.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      responseType: ResponseType.json,
    ),
  );

  return dio;
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  final storageService = ref.watch(storageServiceProvider);
  return ApiClient(dio, storageService);
});

class ApiClient {
  final Dio _dio;
  final StorageService _storageService;

  ApiClient(this._dio, this._storageService);

  Future<Options> _buildOptions({
    Map<String, dynamic>? headers,
    bool requiresAuth = false,
    Duration? timeout,
  }) async {
    final mergedHeaders = <String, dynamic>{
      ...?headers,
    };

    if (requiresAuth) {
      final token = await _storageService.getAccessToken();
      if (token != null && token.isNotEmpty) {
        mergedHeaders['Authorization'] = 'Bearer $token';
      }
    }

    return Options(
      headers: mergedHeaders,
      sendTimeout: timeout,
      receiveTimeout: timeout,
    );
  }

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool requiresAuth = false,
    Duration? timeout,
  }) async {
    try {
      final options = await _buildOptions(
        headers: headers,
        requiresAuth: requiresAuth,
        timeout: timeout,
      );

      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
      );

      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<dynamic> post(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool requiresAuth = false,
    Duration? timeout,
  }) async {
    try {
      final options = await _buildOptions(
        headers: headers,
        requiresAuth: requiresAuth,
        timeout: timeout,
      );

      final response = await _dio.post(
        url,
        data: body,
        queryParameters: queryParameters,
        options: options,
      );

      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<dynamic> put(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool requiresAuth = false,
    Duration? timeout,
  }) async {
    try {
      final options = await _buildOptions(
        headers: headers,
        requiresAuth: requiresAuth,
        timeout: timeout,
      );

      final response = await _dio.put(
        url,
        data: body,
        queryParameters: queryParameters,
        options: options,
      );

      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }

  Future<dynamic> delete(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool requiresAuth = false,
    Duration? timeout,
  }) async {
    try {
      final options = await _buildOptions(
        headers: headers,
        requiresAuth: requiresAuth,
        timeout: timeout,
      );

      final response = await _dio.delete(
        url,
        data: body,
        queryParameters: queryParameters,
        options: options,
      );

      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(e.toString());
    }
  }
}
