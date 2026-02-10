import 'environment.dart';

/// Immutable app configuration (base URL, environment, optional feature flags).
/// No secrets in code; override from env at app startup.
class AppConfig {
  const AppConfig({
    required this.environment,
    required this.baseUrl,
    this.apiKey,
    this.featureFlags = const {},
    this.connectTimeoutMs = 30000,
    this.receiveTimeoutMs = 30000,
  });

  final Environment environment;
  final String baseUrl;
  final String? apiKey;
  final Map<String, bool> featureFlags;
  final int connectTimeoutMs;
  final int receiveTimeoutMs;

  bool get isDev => environment == Environment.dev;
  bool get isUat => environment == Environment.uat;
  bool get isProd => environment == Environment.prod;
  bool get isTest => environment == Environment.test;

  bool isFeatureEnabled(String key) => featureFlags[key] ?? false;

  /// Dev config with common defaults.
  factory AppConfig.forDev({
    String baseUrl = 'https://api.dev.example.com',
    Map<String, bool> featureFlags = const {},
  }) =>
      AppConfig(
        environment: Environment.dev,
        baseUrl: baseUrl,
        featureFlags: featureFlags,
      );

  /// UAT config.
  factory AppConfig.forUat({
    String baseUrl = 'https://api.uat.example.com',
    Map<String, bool> featureFlags = const {},
  }) =>
      AppConfig(
        environment: Environment.uat,
        baseUrl: baseUrl,
        featureFlags: featureFlags,
      );

  /// Prod config.
  factory AppConfig.forProd({
    required String baseUrl,
    String? apiKey,
    Map<String, bool> featureFlags = const {},
  }) =>
      AppConfig(
        environment: Environment.prod,
        baseUrl: baseUrl,
        apiKey: apiKey,
        featureFlags: featureFlags,
      );

  AppConfig copyWith({
    Environment? environment,
    String? baseUrl,
    String? apiKey,
    Map<String, bool>? featureFlags,
    int? connectTimeoutMs,
    int? receiveTimeoutMs,
  }) =>
      AppConfig(
        environment: environment ?? this.environment,
        baseUrl: baseUrl ?? this.baseUrl,
        apiKey: apiKey ?? this.apiKey,
        featureFlags: featureFlags ?? this.featureFlags,
        connectTimeoutMs: connectTimeoutMs ?? this.connectTimeoutMs,
        receiveTimeoutMs: receiveTimeoutMs ?? this.receiveTimeoutMs,
      );
}
