import 'package:flutter/foundation.dart';

import '../../../data/providers/llm/llm_provider.dart';
import '../response_builder.dart';

@immutable
class ChatViewModel {
  const ChatViewModel({
    required this.provider,
    required this.responseBuilder,
    required this.messageSender,
    required this.initialMessage,
  });

  final LlmProvider provider;
  final ResponseBuilder? responseBuilder;
  final LlmStreamGenerator? messageSender;
  final String? initialMessage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatViewModel &&
          other.provider == provider &&
          other.responseBuilder == responseBuilder &&
          other.messageSender == messageSender &&
          other.initialMessage == initialMessage);

  @override
  int get hashCode => Object.hash(
        provider,
        responseBuilder,
        messageSender,
        initialMessage,
      );
}
