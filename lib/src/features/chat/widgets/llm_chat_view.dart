import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../../data/providers/llm/llm_provider.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../llm_response.dart';
import '../response_builder.dart';
import '../view_model/chat_view_model.dart';
import '../view_model/chat_view_model_provider.dart';
import 'llm_chat_history_view.dart';
import 'llm_chat_input_view.dart';

@immutable
class LlmChatView extends StatefulWidget {
  LlmChatView({
    super.key,
    required LlmProvider provider,
    String? initialMessage,
    ResponseBuilder? responseBuilder,
    LlmStreamGenerator? messageSender,
  }) : viewModel = ChatViewModel(
          provider: provider,
          initialMessage: initialMessage,
          responseBuilder: responseBuilder,
          messageSender: messageSender,
        );

  late final ChatViewModel viewModel;

  @override
  State<LlmChatView> createState() => _LlmChatViewState();
}

class _LlmChatViewState extends State<LlmChatView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    widget.viewModel.provider.addListener(_onHistoryChanged);
    super.initState();
  }

  @override
  void dispose() {
    widget.viewModel.provider.removeListener(_onHistoryChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ListenableBuilder(
      listenable: widget.viewModel.provider,
      builder: (context, child) {
        return ChatViewModelProvider(
          viewModel: widget.viewModel,
          child: Column(
            children: [
              Expanded(
                child: LlmChatHistoryView(
                  onEditMessage: (message) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.all(context.spacingMd),
                child: SafeArea(
                  child: LlmChatInputView(
                    onSend: (message) => _onSendMessage(message),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onHistoryChanged() {
    if (widget.viewModel.provider.history.isEmpty) {
      setState(() {});
    }
  }

  Future<void> _onSendMessage(String prompt) async {
    final sendMessageStream = widget.viewModel.messageSender ??
        widget.viewModel.provider.sendMessageStream;

    LlmResponse(
      stream: sendMessageStream(prompt, attachments: []),
      onUpdate: (_) => setState(() {}),
      onDone: (_) => setState(() {}),
    );

    setState(() {});
  }
}
