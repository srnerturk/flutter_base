import 'package:dio/dio.dart';

/// Injects auth token into requests via [getToken]. Add to Dio interceptors.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.getToken});

  final Future<String?> Function() getToken;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
