import 'package:flutter/widgets.dart';

import 'chat_view_model.dart';
import 'chat_view_model_provider.dart';

@immutable
class ChatViewModelClient extends StatelessWidget {
  const ChatViewModelClient({super.key, required this.builder, this.child});

  final Widget Function(
    BuildContext context,
    ChatViewModel viewModel,
    Widget? child,
  ) builder;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return builder(context, ChatViewModelProvider.of(context), child);
  }
}
