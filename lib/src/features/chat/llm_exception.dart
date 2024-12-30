import 'package:flutter/foundation.dart';

@immutable
abstract class LlmException implements Exception {
  const LlmException._([this.message = '']);
  final String message;

  @override
  String toString() => 'LlmException: $message';
}

class LlmCancelException extends LlmException {
  const LlmCancelException() : super._();

  @override
  String toString() => 'LlmCancelException';
}

class LlmFailureException extends LlmException {
  const LlmFailureException([super.message]) : super._();

  @override
  String toString() => 'LlmFailureException: $message';
}
