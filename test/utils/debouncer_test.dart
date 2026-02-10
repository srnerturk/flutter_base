import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mbvn_flutter_base/src/utils/debouncer.dart';

void main() {
  group('Debouncer', () {
    test('run schedules action after delay', () async {
      var called = 0;
      final d = Debouncer(delay: Duration(milliseconds: 50));
      d.run(() => called++);
      expect(called, 0);
      await Future<void>.delayed(Duration(milliseconds: 60));
      expect(called, 1);
    });

    test('cancel prevents execution', () async {
      var called = 0;
      final d = Debouncer(delay: Duration(milliseconds: 50));
      d.run(() => called++);
      d.cancel();
      await Future<void>.delayed(Duration(milliseconds: 60));
      expect(called, 0);
    });
  });
}
