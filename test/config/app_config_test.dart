import 'package:flutter_test/flutter_test.dart';
import 'package:mbvn_flutter_base/src/config/config.dart';

void main() {
  group('AppConfig', () {
    test('forDev sets environment and baseUrl', () {
      final c = AppConfig.forDev(baseUrl: 'https://dev.api');
      expect(c.environment, Environment.dev);
      expect(c.baseUrl, 'https://dev.api');
      expect(c.isDev, isTrue);
    });

    test('isFeatureEnabled returns flag value', () {
      final c = AppConfig.forDev(
        featureFlags: {'foo': true, 'bar': false},
      );
      expect(c.isFeatureEnabled('foo'), isTrue);
      expect(c.isFeatureEnabled('bar'), isFalse);
      expect(c.isFeatureEnabled('baz'), isFalse);
    });
  });
}
