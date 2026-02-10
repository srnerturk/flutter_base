import 'package:flutter_test/flutter_test.dart';
import 'package:mbvn_flutter_base/src/error_result/app_error.dart';

void main() {
  group('AppError', () {
    test('displayMessage uses userMessage when set', () {
      const err = AppError(
        kind: AppErrorKind.unknown,
        userMessage: 'Custom message',
      );
      expect(err.displayMessage, 'Custom message');
    });

    test('displayMessage uses default for network', () {
      const err = AppError(kind: AppErrorKind.network);
      expect(err.displayMessage, contains('connection'));
    });

    test('displayMessage falls back to message when no userMessage', () {
      const err = AppError(
        kind: AppErrorKind.unknown,
        message: 'Technical detail',
      );
      expect(err.displayMessage, 'Technical detail');
    });
  });
}
