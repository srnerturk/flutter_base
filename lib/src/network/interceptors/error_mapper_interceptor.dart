import 'package:dio/dio.dart';

import '../../error_result/error_result.dart';

/// Maps [DioException] to [AppError]. Used internally by [AppHttpClient];
/// the client catches DioException and converts to Failure(AppError).
AppError mapDioExceptionToAppError(DioException err) {
  final response = err.response;
  final statusCode = response?.statusCode;
  final data = response?.data;

  String? serverMessage;
  if (data is Map<String, dynamic> && data.containsKey('message')) {
    final m = data['message'];
    serverMessage = m is String ? m : m?.toString();
  }

  switch (err.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return AppError(
        kind: AppErrorKind.network,
        message: err.message,
        userMessage: serverMessage,
      );
    case DioExceptionType.badResponse:
      if (statusCode != null) {
        if (statusCode == 401) {
          return AppError(
            kind: AppErrorKind.unauthorized,
            message: serverMessage ?? err.message,
            code: statusCode.toString(),
          );
        }
        if (statusCode == 404) {
          return AppError(
            kind: AppErrorKind.notFound,
            message: serverMessage ?? err.message,
            code: statusCode.toString(),
          );
        }
        if (statusCode >= 500) {
          return AppError(
            kind: AppErrorKind.server,
            message: serverMessage ?? err.message,
            code: statusCode.toString(),
          );
        }
        return AppError(
          kind: AppErrorKind.server,
          message: serverMessage ?? err.message,
          code: statusCode.toString(),
        );
      }
      return AppError(
        kind: AppErrorKind.unknown,
        message: err.message,
      );
    case DioExceptionType.cancel:
      return AppError(
        kind: AppErrorKind.unknown,
        message: 'Request cancelled',
      );
    default:
      return AppError(
        kind: AppErrorKind.unknown,
        message: err.message,
      );
  }
}
