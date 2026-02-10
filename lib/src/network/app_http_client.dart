import 'package:dio/dio.dart';

import '../config/config.dart';
import '../error_result/error_result.dart';
import '../utils/logger.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_mapper_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

/// Dio-based HTTP client returning [Result<T>]. No raw [DioException] in public API.
class AppHttpClient {
  AppHttpClient({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    AppConfig? config,
    Future<String?> Function()? getToken,
    AppLogger? logger,
    List<Interceptor>? customInterceptors,
  })  : _config = config,
        _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? config?.baseUrl ?? '',
            connectTimeout: connectTimeout ??
                Duration(milliseconds: config?.connectTimeoutMs ?? 30000),
            receiveTimeout: receiveTimeout ??
                Duration(milliseconds: config?.receiveTimeoutMs ?? 30000),
          ),
        ) {
    final interceptors = <Interceptor>[];
    if (getToken != null) {
      interceptors.add(AuthInterceptor(getToken: getToken));
    }
    interceptors.add(LoggingInterceptor(logger: logger, environment: config?.environment));
    if (customInterceptors != null) {
      interceptors.addAll(customInterceptors);
    }
    _dio.interceptors.addAll(interceptors);
  }

  final AppConfig? _config;
  final Dio _dio;

  /// Raw Dio instance for advanced use (e.g. custom interceptors). Prefer [get], [post], etc.
  Dio get dio => _dio;

  /// GET request. Returns [Success] with response body or [Failure] with [AppError].
  Future<Result<Response>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(mapDioExceptionToAppError(e));
    }
  }

  /// POST request.
  Future<Result<Response>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(mapDioExceptionToAppError(e));
    }
  }

  /// PUT request.
  Future<Result<Response>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(mapDioExceptionToAppError(e));
    }
  }

  /// DELETE request.
  Future<Result<Response>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return Success(response);
    } on DioException catch (e) {
      return Failure(mapDioExceptionToAppError(e));
    }
  }

  /// GET JSON and parse to [T] via [fromJson]. Returns [Failure] on parse error.
  Future<Result<T>> getJson<T>(
    String path, {
    required T Function(Map<String, dynamic> json) fromJson,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final result = await get(path, queryParameters: queryParameters, options: options);
    return result.fold(
      (response) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          try {
            return Success(fromJson(data));
          } catch (e) {
            return Failure(AppError(
              kind: AppErrorKind.unknown,
              message: e.toString(),
            ));
          }
        }
        if (data is List) {
          // Optional: support list at root. For now treat as error if fromJson expects map.
          return Failure(const AppError(
            kind: AppErrorKind.unknown,
            message: 'Expected JSON object',
          ));
        }
        return Failure(const AppError(
          kind: AppErrorKind.unknown,
          message: 'Invalid response format',
        ));
      },
      (error) => Failure(error),
    );
  }
}
