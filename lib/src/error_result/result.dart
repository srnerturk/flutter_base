import 'app_error.dart';

/// Result type representing either success with a value or failure with [AppError].
sealed class Result<T> {
  const Result();

  /// Returns `true` if this is [Success].
  bool get isSuccess => this is Success<T>;

  /// Returns `true` if this is [Failure].
  bool get isFailure => this is Failure<T>;

  /// Returns the value if [Success], otherwise `null`.
  T? get valueOrNull => switch (this) {
        Success(:final value) => value,
        Failure() => null,
      };

  /// Returns the [AppError] if [Failure], otherwise `null`.
  AppError? get errorOrNull => switch (this) {
        Success() => null,
        Failure(:final error) => error,
      };

  /// Maps the value of [Success]; [Failure] is passed through.
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
        Success(:final value) => Success(transform(value)),
        Failure(:final error) => Failure(error),
      };

  /// Flat-maps the value of [Success]; [Failure] is passed through.
  Result<R> flatMap<R>(Result<R> Function(T value) transform) => switch (this) {
        Success(:final value) => transform(value),
        Failure(:final error) => Failure(error),
      };

  /// Folds into a single value using [onSuccess] or [onFailure].
  R fold<R>(R Function(T value) onSuccess, R Function(AppError error) onFailure) =>
      switch (this) {
        Success(:final value) => onSuccess(value),
        Failure(:final error) => onFailure(error),
      };
}

/// Successful result containing [value].
final class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
}

/// Failed result containing [error].
final class Failure<T> extends Result<T> {
  const Failure(this.error);
  final AppError error;

  /// User-friendly message for UI display.
  String get userMessage => error.displayMessage;
}
