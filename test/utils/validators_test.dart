import 'package:flutter_test/flutter_test.dart';
import 'package:mbvn_flutter_base/src/utils/validators.dart';

void main() {
  group('validators', () {
    test('required rejects null and empty', () {
      expect(required(null), 'Required');
      expect(required(''), 'Required');
      expect(required('  '), 'Required');
      expect(required('a'), isNull);
    });

    test('email validates format', () {
      expect(email(null), isNull);
      expect(email(''), isNull);
      expect(email('a@b.co'), isNull);
      expect(email('invalid'), isNotNull);
    });

    test('minLength', () {
      expect(minLength('ab', 3), isNotNull);
      expect(minLength('abc', 3), isNull);
    });

    test('combine runs in order', () {
      expect(
        combine('', [required, (v) => minLength(v, 5)]),
        'Required',
      );
      expect(
        combine('x', [required, (v) => minLength(v, 5)]),
        'Must be at least 5 characters',
      );
    });
  });
}
