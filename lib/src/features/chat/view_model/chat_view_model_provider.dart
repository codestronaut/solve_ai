import 'package:flutter/widgets.dart';

import 'chat_view_model.dart';

@immutable
class ChatViewModelProvider extends InheritedWidget {
  const ChatViewModelProvider({
    super.key,
    required super.child,
    required this.viewModel,
  });

  final ChatViewModel viewModel;

  static ChatViewModel of(BuildContext context) {
    final viewModel = maybeOf(context);
    assert(viewModel != null, 'No ChatViewModelProvider found in context');
    return viewModel!;
  }

  static ChatViewModel? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<ChatViewModelProvider>()
      ?.viewModel;

  @override
  bool updateShouldNotify(ChatViewModelProvider oldWidget) {
    return viewModel != oldWidget.viewModel;
  }
}
