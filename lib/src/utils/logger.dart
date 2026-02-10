import '../config/config.dart';

/// Log level.
enum LogLevel {
  none,
  error,
  warning,
  info,
  debug,
}

/// Environment-aware logger. Verbose in dev, minimal in prod.
class AppLogger {
  AppLogger({
    this.level,
    this.environment,
    void Function(String message, LogLevel level)? sink,
  }) : _sink = sink ?? _defaultSink;

  final LogLevel? level;
  final Environment? environment;
  final void Function(String message, LogLevel level) _sink;

  static void _defaultSink(String message, LogLevel level) {
    // ignore: avoid_print
    print('[$level] $message');
  }

  LogLevel get effectiveLevel {
    if (level != null) return level!;
    switch (environment) {
      case Environment.dev:
      case Environment.uat:
      case Environment.test:
        return LogLevel.debug;
      case Environment.prod:
        return LogLevel.warning;
      case null:
        return LogLevel.info;
    }
  }

  bool _shouldLog(LogLevel messageLevel) {
    final effective = effectiveLevel;
    if (effective == LogLevel.none) return false;
    return messageLevel.index <= effective.index;
  }

  void debug(String message) {
    if (_shouldLog(LogLevel.debug)) _sink(message, LogLevel.debug);
  }

  void info(String message) {
    if (_shouldLog(LogLevel.info)) _sink(message, LogLevel.info);
  }

  void warning(String message) {
    if (_shouldLog(LogLevel.warning)) _sink(message, LogLevel.warning);
  }

  void error(String message) {
    if (_shouldLog(LogLevel.error)) _sink(message, LogLevel.error);
  }
}
