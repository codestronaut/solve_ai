import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../domain/models/attachment/attachment.dart';
import '../../../domain/models/message/chat_message.dart';
import '../../../domain/models/message/chat_message_origin.dart';
import 'llm_provider.dart';

class LlmGeminiProvider extends LlmProvider with ChangeNotifier {
  @immutable
  LlmGeminiProvider({
    required GenerativeModel model,
    Iterable<ChatMessage>? history,
    List<SafetySetting>? chatSafetySettings,
    GenerationConfig? chatGenerationConfig,
  })  : _model = model,
        _history = history?.toList() ?? [],
        _chatSafetySettings = chatSafetySettings,
        _chatGenerationConfig = chatGenerationConfig {
    _chat = _startChat(history);
  }

  final GenerativeModel _model;
  final List<ChatMessage> _history;
  final List<SafetySetting>? _chatSafetySettings;
  final GenerationConfig? _chatGenerationConfig;
  ChatSession? _chat;

  @override
  Stream<String> generateStream(
    String prompt, {
    Iterable<Attachment> attachments = const [],
  }) {
    return _generateStream(
      prompt: prompt,
      attachments: attachments,
      contentStreamGenerator: (c) => _model.generateContentStream([c]),
    );
  }

  @override
  Stream<String> sendMessageStream(
    String prompt, {
    Iterable<Attachment> attachments = const [],
  }) async* {
    final userMessage = ChatMessage.user(prompt, attachments);
    final llmMessage = ChatMessage.llm();
    _history.addAll([userMessage, llmMessage]);

    final response = _generateStream(
      prompt: prompt,
      attachments: attachments,
      contentStreamGenerator: _chat!.sendMessageStream,
    );

    yield* response.map((chunk) {
      llmMessage.append(chunk);
      return chunk;
    });

    notifyListeners();
  }

  @override
  Iterable<ChatMessage> get history => _history;

  @override
  set history(Iterable<ChatMessage> history) {
    _history.clear();
    _history.addAll(history);
    _chat = _startChat(history);
    notifyListeners();
  }

  Stream<String> _generateStream({
    required String prompt,
    required Iterable<Attachment> attachments,
    required Stream<GenerateContentResponse> Function(Content)
        contentStreamGenerator,
  }) async* {
    final content = Content('user', [
      TextPart(prompt),
      ...attachments.map(_partFrom),
    ]);

    final response = contentStreamGenerator(content);
    yield* response
        .map((chunk) => chunk.text)
        .where((text) => text != null)
        .cast<String>();
  }

  ChatSession? _startChat(Iterable<ChatMessage>? history) {
    return _model.startChat(
      history: history?.map(_contentFrom).toList(),
      safetySettings: _chatSafetySettings,
      generationConfig: _chatGenerationConfig,
    );
  }

  static Part _partFrom(Attachment attachment) {
    return switch (attachment) {
      (final FileAttachment a) => DataPart(a.mimeType, a.bytes),
      (final LinkAttachment a) => FilePart(a.url),
    };
  }

  static Content _contentFrom(ChatMessage message) {
    return Content(message.origin.isUser ? 'user' : 'model', [
      TextPart(message.text ?? ''),
      ...message.attachments.map(_partFrom),
    ]);
  }
}
