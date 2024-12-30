import 'package:flutter/foundation.dart';

import '../../../domain/models/attachment/attachment.dart';
import '../../../domain/models/message/chat_message.dart';

abstract class LlmProvider implements Listenable {
  Stream<String> generateStream(
    String prompt, {
    Iterable<Attachment> attachments,
  });
  Stream<String> sendMessageStream(
    String prompt, {
    Iterable<Attachment> attachments,
  });
  Iterable<ChatMessage> get history;
  set history(Iterable<ChatMessage> history);
}

typedef LlmStreamGenerator = Stream<String> Function(
  String prompt, {
  required Iterable<Attachment> attachments,
});
