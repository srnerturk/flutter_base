/// Abstraction for application errors with optional user-facing message.
class AppError {
  const AppError({
    required this.kind,
    this.message,
    this.code,
    this.userMessage,
  });

  final AppErrorKind kind;
  final String? message;
  final String? code;
  final String? userMessage;

  /// User-facing message; falls back to [userMessage] or a generic message.
  String get displayMessage =>
      userMessage ?? _defaultUserMessage ?? message ?? 'Something went wrong';

  String? get _defaultUserMessage {
    switch (kind) {
      case AppErrorKind.network:
        return 'Please check your connection and try again.';
      case AppErrorKind.validation:
        return message ?? 'Please check your input.';
      case AppErrorKind.server:
        return 'Server error. Please try again later.';
      case AppErrorKind.unauthorized:
        return 'Session expired. Please sign in again.';
      case AppErrorKind.notFound:
        return 'The requested resource was not found.';
      case AppErrorKind.unknown:
        return 'Something went wrong. Please try again.';
    }
  }

  @override
  String toString() => 'AppError($kind, message: $message, code: $code)';
}

/// Categories of application errors.
enum AppErrorKind {
  network,
  validation,
  server,
  unauthorized,
  notFound,
  unknown,
}
