enum ChatMessageOrigin { user, llm }

extension ChatMessageOriginX on ChatMessageOrigin {
  bool get isUser => this == ChatMessageOrigin.user;
  bool get isLlm => this == ChatMessageOrigin.llm;
}
