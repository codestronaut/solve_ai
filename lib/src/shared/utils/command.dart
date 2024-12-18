import 'package:flutter/foundation.dart';

import 'result.dart';

typedef CommandAction0<T> = Future<Result<T>> Function();
typedef CommandAction1<T, A> = Future<Result<T>> Function(A);

abstract class Command<T> extends ChangeNotifier {
  Command();

  /// True when action is running.
  bool _running = false;
  bool get running => _running;

  Result<T>? _result;

  /// True when action completed successfully.
  bool get completed => _result is Ok;

  /// True when action completed with error.
  bool get error => _result is Error;

  /// Get last action result.
  Result? get result => _result;

  /// Clear last action result.
  void clearResult() {
    _result = null;
    notifyListeners();
  }

  /// Internal execute implementation.
  Future<void> _execute(CommandAction0<T> action) async {
    /// Ensure the action can't launch multiple times.
    /// e.g. avoid multiple taps on button.
    if (_running) return;

    /// Notify listeners.
    /// e.g. button shows loading state.
    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

/// [Command] without arguments.
/// Takes a [CommandAction0] as action.
class Command0<T> extends Command<T> {
  Command0(this._action);

  final CommandAction0<T> _action;

  /// Execute the action.
  Future<void> execute() async {
    await _execute(() => _action());
  }
}

/// [Command] with arguments.
/// Takes a [CommandAction1] as action.
class Command1<T, A> extends Command<T> {
  Command1(this._action);

  final CommandAction1<T, A> _action;

  /// Execute the action.
  Future<void> execute(A argument) async {
    await _execute(() => _action(argument));
  }
}
