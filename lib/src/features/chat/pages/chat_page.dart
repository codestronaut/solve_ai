import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../data/providers/llm/llm_gemini_provider.dart';
import '../../../shared/assets/colors.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../../home/widgets/tools/tools_menu.dart';
import '../widgets/llm_chat_view.dart';

@RoutePage()
class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.toolsMenu});
  final ToolsMenu toolsMenu;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late LlmGeminiProvider llmProvider;

  @override
  void initState() {
    llmProvider = LlmGeminiProvider(
      /// Note: GenerativeModel from Gemini SDK only for development.
      model: GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: const String.fromEnvironment('API_KEY', defaultValue: ''),
        systemInstruction: Content('model', [
          TextPart(widget.toolsMenu.getSystemPrompt().trim()),
        ]),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          spacing: context.spacingMd,
          children: [
            SvgPicture.asset(widget.toolsMenu.getIconPath()),
            Text(widget.toolsMenu.getLabel(context)),
          ],
        ),
        titleTextStyle: context.textTheme.headlineMedium.ny
            ?.copyWith(fontWeight: FontWeight.w700),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.spacingMd),
            child: ClipOval(
              child: Material(
                color: context.isLightMode
                    ? ColorName.secondary
                    : ColorName.secondaryDark,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: SizedBox(
                    width: context.spacingMd * 2.4,
                    height: context.spacingMd * 2.4,
                    child: Icon(
                      Icons.close,
                      size: context.spacingLg,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: LlmChatView(
        initialMessage: widget.toolsMenu.getInitialMessage(context),
        provider: llmProvider,
      ),
    );
  }
}
