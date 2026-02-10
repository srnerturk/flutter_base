import 'package:flutter_test/flutter_test.dart';
import 'package:mbvn_flutter_base/src/error_result/error_result.dart';

void main() {
  group('Result', () {
    group('Success', () {
      test('isSuccess is true', () {
        const r = Success<int>(42);
        expect(r.isSuccess, isTrue);
        expect(r.isFailure, isFalse);
      });

      test('valueOrNull returns value', () {
        const r = Success<int>(42);
        expect(r.valueOrNull, 42);
        expect(r.errorOrNull, isNull);
      });

      test('map transforms value', () {
        const r = Success<int>(42);
        final mapped = r.map((v) => v * 2);
        expect(mapped, isA<Success<int>>());
        expect((mapped as Success).value, 84);
      });

      test('fold calls onSuccess', () {
        const r = Success<int>(42);
        final result = r.fold((v) => 'ok:$v', (_) => 'err');
        expect(result, 'ok:42');
      });
    });

    group('Failure', () {
      test('isFailure is true', () {
        const err = AppError(kind: AppErrorKind.network);
        const r = Failure<int>(err);
        expect(r.isSuccess, isFalse);
        expect(r.isFailure, isTrue);
      });

      test('errorOrNull returns error', () {
        const err = AppError(kind: AppErrorKind.validation, message: 'Bad');
        const r = Failure<int>(err);
        expect(r.valueOrNull, isNull);
        expect(r.errorOrNull, err);
      });

      test('map preserves failure', () {
        const err = AppError(kind: AppErrorKind.server);
        const r = Failure<int>(err);
        final mapped = r.map((v) => v * 2);
        expect(mapped, isA<Failure<int>>());
        expect((mapped as Failure).error, err);
      });

      test('userMessage returns displayMessage', () {
        const err = AppError(kind: AppErrorKind.network);
        const r = Failure<int>(err);
        expect(r.userMessage, isNotEmpty);
      });

      test('fold calls onFailure', () {
        const err = AppError(kind: AppErrorKind.unknown);
        const r = Failure<int>(err);
        final result = r.fold((v) => 'ok:$v', (e) => 'err:${e.kind}');
        expect(result, 'err:AppErrorKind.unknown');
      });
    });
  });
}
