import 'dart:async';

import 'llm_exception.dart';

class LlmResponse {
  LlmResponse({
    required Stream<String> stream,
    required this.onUpdate,
    required this.onDone,
  }) {
    _subscription = stream.listen(
      onUpdate,
      onDone: () => onDone(null),
      cancelOnError: true,
      onError: (error) => _close(_exception(error)),
    );
  }

  final void Function(String text) onUpdate;
  final void Function(LlmException? error) onDone;
  StreamSubscription<String>? _subscription;

  LlmException _exception(dynamic error) => switch (error) {
        (LlmCancelException _) => const LlmCancelException(),
        (final LlmFailureException exception) => exception,
        _ => LlmFailureException(error.toString()),
      };

  void _close(LlmException error) {
    assert(_subscription != null);
    unawaited(_subscription!.cancel());
    _subscription = null;
    onDone.call(error);
  }
}
