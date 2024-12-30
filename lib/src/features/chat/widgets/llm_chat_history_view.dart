import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/message/chat_message.dart';
import '../../../domain/models/message/chat_message_origin.dart';
import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../view_model/chat_view_model_client.dart';

@immutable
class LlmChatHistoryView extends StatefulWidget {
  const LlmChatHistoryView({super.key, this.onEditMessage});
  final ValueChanged<ChatMessage>? onEditMessage;

  @override
  State<LlmChatHistoryView> createState() => _LlmChatHistoryViewState();
}

class _LlmChatHistoryViewState extends State<LlmChatHistoryView> {
  final _scrollController = ScrollController();
  bool _showScrollToBottomButton = false;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels <= 0) {
      setState(() => _showScrollToBottomButton = false);
    } else {
      setState(() => _showScrollToBottomButton = true);
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChatViewModelClient(
      builder: (context, viewModel, child) {
        final history = [
          if (viewModel.initialMessage != null)
            ChatMessage(
              text: viewModel.initialMessage,
              origin: ChatMessageOrigin.llm,
              attachments: [],
            ),
          ...viewModel.provider.history,
        ];

        return Stack(
          clipBehavior: Clip.none,
          children: [
            ListView.separated(
              reverse: true,
              controller: _scrollController,
              padding: EdgeInsets.symmetric(
                horizontal: context.spacingMd,
                vertical: context.spacingXlg,
              ),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final messageIndex = history.length - index - 1;
                final message = history[messageIndex];

                return switch (message.origin) {
                  ChatMessageOrigin.user =>
                    _RequestChatBubble(text: message.text.orEmpty),
                  ChatMessageOrigin.llm =>
                    _ResponseChatBubble(text: message.text.orEmpty),
                };
              },
              separatorBuilder: (context, index) {
                return context.spacingMd.vSpace;
              },
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: context.spacingXlg * 1.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorName.backgroundDark,
                      ColorName.backgroundDark.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: context.spacingXlg * 1.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      ColorName.backgroundDark,
                      ColorName.backgroundDark.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -context.spacingMd,
              child: AnimatedScale(
                scale: _showScrollToBottomButton ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeInOut,
                child: IgnorePointer(
                  ignoring: !_showScrollToBottomButton,
                  child: FloatingActionButton(
                    mini: true,
                    onPressed: _scrollToBottom,
                    backgroundColor: ColorName.backgroundSecondaryDark,
                    foregroundColor: ColorName.primary,
                    shape: const CircleBorder(
                      side: BorderSide(color: ColorName.primary),
                    ),
                    child: const Icon(Icons.arrow_downward),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RequestChatBubble extends StatelessWidget {
  const _RequestChatBubble({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: context.spacingMd * 2),
      padding: EdgeInsets.all(context.spacingMd),
      decoration: BoxDecoration(
        color: context.isLightMode
            ? ColorName.backgroundSecondaryLight
            : ColorName.backgroundSecondaryDark,
        borderRadius: BorderRadius.only(
          topLeft: context.spacingMd.radius,
          topRight: context.spacingMd.radius,
          bottomLeft: context.spacingMd.radius,
        ),
      ),
      child: Text(
        text,
        style: context.textTheme.bodyLarge.sf?.copyWith(
          color: CupertinoColors.label.resolveFrom(context),
        ),
      ),
    );
  }
}

class _ResponseChatBubble extends StatelessWidget {
  const _ResponseChatBubble({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: context.spacingMd * 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(context.spacingXs),
            decoration: ShapeDecoration(
              shape: const CircleBorder(),
              color: context.isLightMode
                  ? ColorName.backgroundSecondaryLight
                  : ColorName.backgroundSecondaryDark,
            ),
            child: Center(
              child: Assets.images.brandDarkSvg.svg(
                width: context.spacingMd,
                height: context.spacingMd,
              ),
            ),
          ),
          context.spacingSm.hSpace,
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodyLarge.sf?.copyWith(
                color: CupertinoColors.label.resolveFrom(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
