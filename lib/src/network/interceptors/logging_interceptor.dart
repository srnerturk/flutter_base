import 'package:dio/dio.dart';

import '../../config/config.dart';
import '../../utils/logger.dart';

/// Logs requests/responses in dev/uat; minimal in prod. Use with [AppLogger].
class LoggingInterceptor extends Interceptor {
  LoggingInterceptor({AppLogger? logger, Environment? environment})
      : _logger = logger ?? AppLogger(environment: environment);

  final AppLogger _logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_logger.effectiveLevel.index >= LogLevel.debug.index) {
      _logger.debug('→ ${options.method} ${options.uri}');
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    if (_logger.effectiveLevel.index >= LogLevel.debug.index) {
      _logger.debug('← ${response.statusCode} ${response.requestOptions.uri}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.warning('✗ ${err.requestOptions.uri} ${err.message}');
    handler.next(err);
  }
}
