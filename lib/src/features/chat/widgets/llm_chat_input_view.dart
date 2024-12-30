import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../domain/models/message/chat_message.dart';
import '../../../domain/models/message/chat_message_origin.dart';
import '../../../shared/assets/assets.gen.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../view_model/chat_view_model_client.dart';

class LlmChatInputView extends StatefulWidget {
  const LlmChatInputView({super.key, required this.onSend});
  final ValueChanged<String> onSend;

  @override
  State<LlmChatInputView> createState() => _LlmChatInputViewState();
}

class _LlmChatInputViewState extends State<LlmChatInputView> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const fillColor = CupertinoColors.tertiarySystemBackground;
    const onFillColor = CupertinoColors.systemGrey2;
    const hintColor = CupertinoColors.secondaryLabel;

    return Padding(
      padding: EdgeInsets.only(top: context.spacingMd),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipOval(
            child: Material(
              color: context.isLightMode
                  ? ColorName.secondary
                  : ColorName.secondaryDark,
              child: InkWell(
                onTap: () {},
                child: SizedBox(
                  width: context.spacingXlg * 2,
                  height: context.spacingXlg * 2,
                  child: Icon(Icons.add, size: context.spacingLg),
                ),
              ),
            ),
          ),
          context.spacingXs.hSpace,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: fillColor.resolveFrom(context),
                borderRadius: context.spacingXlg.borderRadius,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: ChatViewModelClient(
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

                        return TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: history.length > 2
                                ? context.l10n.askFollowUp
                                : context.l10n.askSolveAi,
                            hintStyle: context.textTheme.bodyLarge.sf?.copyWith(
                              color: hintColor.resolveFrom(context),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: context.spacingLg.borderRadius,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: context.spacingXs,
                              horizontal: context.spacingMd,
                            ),
                          ),
                          minLines: 1,
                          maxLines: 4,
                        );
                      },
                    ),
                  ),
                  context.spacingXxs.hSpace,
                  ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (context, value, child) {
                      if (value.text.isNotEmpty) {
                        return IconButton(
                          onPressed: () {
                            widget.onSend(controller.text.trim());
                            controller.clear();
                          },
                          color: Colors.white,
                          icon: const Icon(Icons.arrow_upward),
                          style: IconButton.styleFrom(
                            backgroundColor: ColorName.primary,
                          ),
                        ).animate().fade();
                      }

                      return IconButton(
                        onPressed: () {},
                        icon: Assets.icons.icMicrophone.svg(
                          colorFilter: ColorFilter.mode(
                            onFillColor.resolveFrom(context),
                            BlendMode.srcIn,
                          ),
                        ),
                      ).animate().fade();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
