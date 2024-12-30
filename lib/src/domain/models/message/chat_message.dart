import 'dart:convert';

import '../attachment/attachment.dart';
import 'chat_message_origin.dart';

class ChatMessage {
  ChatMessage({
    required this.text,
    required this.origin,
    required this.attachments,
  }) : assert(origin.isUser && text != null && text.isNotEmpty || origin.isLlm);

  String? text;
  final ChatMessageOrigin origin;
  final Iterable<Attachment> attachments;

  factory ChatMessage.user(String text, Iterable<Attachment> attachments) =>
      ChatMessage(
        text: text,
        origin: ChatMessageOrigin.user,
        attachments: attachments,
      );

  factory ChatMessage.llm() => ChatMessage(
        text: null,
        origin: ChatMessageOrigin.llm,
        attachments: [],
      );

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        text: json['text'] as String,
        origin: ChatMessageOrigin.values.byName(json['origin'] as String),
        attachments: [
          for (final attachment in json['attachments'] as List<dynamic>)
            switch (attachment['type'] as String) {
              'file' => FileAttachment.fileOrImage(
                  name: attachment['name'] as String,
                  mimeType: attachment['mimeType'] as String,
                  bytes: base64Decode(attachment['data'] as String),
                ),
              'link' => LinkAttachment(
                  name: attachment['name'] as String,
                  url: Uri.parse(attachment['data'] as String),
                ),
              _ => throw UnimplementedError(),
            },
        ],
      );

  Map<String, dynamic> toJson() => {
        'text': text,
        'origin': origin.name,
        'attachments': [
          for (final attachment in attachments)
            {
              'type': switch (attachment) {
                FileAttachment() => 'file',
                LinkAttachment() => 'link',
              },
              'name': attachment.name,
              'mimeType': switch (attachment) {
                (final FileAttachment a) => a.mimeType,
                (final LinkAttachment a) => a.mimeType,
              },
              'data': switch (attachment) {
                (final FileAttachment a) => base64Encode(a.bytes),
                (final LinkAttachment a) => a.url,
              },
            },
        ],
      };

  void append(String text) => this.text = (this.text ?? '') + text;

  @override
  String toString() => 'ChatMessage('
      'text: $text, '
      'origin: $origin, '
      'attachments: $attachments'
      ')';
}
