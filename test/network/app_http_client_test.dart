import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mbvn_flutter_base/src/error_result/error_result.dart';
import 'package:mbvn_flutter_base/src/network/app_http_client.dart';

void main() {
  group('AppHttpClient', () {
    test('get returns Failure when request is rejected', () async {
      final client = AppHttpClient(
        baseUrl: 'https://example.com',
        customInterceptors: [
          InterceptorsWrapper(
            onRequest: (options, h) => h.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.unknown,
                error: 'cancel',
              ),
            ),
          ),
        ],
      );
      final result = await client.get('/path');
      expect(result.isFailure, isTrue);
      expect(result.errorOrNull, isNotNull);
    });

    test('AppErrorKind.unauthorized is available', () {
      const err = AppError(kind: AppErrorKind.unauthorized);
      expect(err.kind, AppErrorKind.unauthorized);
    });
  });
}
