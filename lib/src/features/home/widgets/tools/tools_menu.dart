import 'package:flutter/widgets.dart';

import '../../../../shared/assets/assets.gen.dart';
import '../../../../shared/extensions/ext_misc.dart';

final toolsMenuGroups = [
  [
    ToolsMenu.askAiAnything,
    ToolsMenu.askAiSummarize,
  ],
  [
    ToolsMenu.writeDraftEssay,
    ToolsMenu.writeImprove,
    ToolsMenu.writeChangeTone,
    ToolsMenu.writeParaphrase,
  ],
  [
    ToolsMenu.languageTranslate,
    ToolsMenu.languageFixGrammar,
  ],
];

enum ToolsMenu {
  askAiAnything,
  askAiSummarize,
  writeDraftEssay,
  writeImprove,
  writeChangeTone,
  writeParaphrase,
  languageTranslate,
  languageFixGrammar;

  String getIconPath() {
    return switch (this) {
      ToolsMenu.askAiAnything => Assets.icons.icFeatAskAnything.path,
      ToolsMenu.askAiSummarize => Assets.icons.icFeatSummarize.path,
      ToolsMenu.writeDraftEssay => Assets.icons.icFeatDraftEssay.path,
      ToolsMenu.writeImprove => Assets.icons.icFeatImprove.path,
      ToolsMenu.writeChangeTone => Assets.icons.icFeatChangeTone.path,
      ToolsMenu.writeParaphrase => Assets.icons.icFeatParaphrase.path,
      ToolsMenu.languageTranslate => Assets.icons.icFeatTranslate.path,
      ToolsMenu.languageFixGrammar => Assets.icons.icFeatFixGrammar.path,
    };
  }

  String getLabel(BuildContext context) {
    return switch (this) {
      ToolsMenu.askAiAnything => context.l10n.askAiAnything,
      ToolsMenu.askAiSummarize => context.l10n.askAiSummarize,
      ToolsMenu.writeDraftEssay => context.l10n.writeDraftEssay,
      ToolsMenu.writeImprove => context.l10n.writeImprove,
      ToolsMenu.writeChangeTone => context.l10n.writeChangeTone,
      ToolsMenu.writeParaphrase => context.l10n.writeParaphrase,
      ToolsMenu.languageTranslate => context.l10n.languageTranslate,
      ToolsMenu.languageFixGrammar => context.l10n.languageFixGrammar,
    };
  }

  String getInitialMessage(BuildContext context) {
    return switch (this) {
      ToolsMenu.askAiAnything => context.l10n.askAiAnythingInitialMsg,
      ToolsMenu.askAiSummarize => context.l10n.askAiSummarizeInitialMsg,
      ToolsMenu.writeDraftEssay => context.l10n.writeDraftEssayInitialMsg,
      ToolsMenu.writeImprove => context.l10n.writeImproveInitialMsg,
      ToolsMenu.writeChangeTone => context.l10n.writeChangeToneInitialMsg,
      ToolsMenu.writeParaphrase => context.l10n.writeParaphraseInitialMsg,
      ToolsMenu.languageTranslate => context.l10n.languageTranslateInitialMsg,
      ToolsMenu.languageFixGrammar => context.l10n.languageFixGrammarInitialMsg,
    };
  }

  String getSystemPrompt() {
    return switch (this) {
      ToolsMenu.askAiAnything => '''
        You are a study assistant who have broad knowledge, 
        help the user to answer any questions they are ask for.
        Note that you have to provide warning response to any questions
        that related to inappropriate things.
      ''',
      ToolsMenu.askAiSummarize => '''
        You are a study assistant who have broad knowledge, 
        help the user to summarize any texts or files they are ask for.
      ''',
      ToolsMenu.writeDraftEssay => '''
        You are a writer expert who have broad knowledge, 
        help the user to draft an essay from the topic they are ask for.
      ''',
      ToolsMenu.writeImprove => '''
        You are a writer expert who have broad knowledge, 
        help the user to improve any texts they are ask for.
      ''',
      ToolsMenu.writeChangeTone => '''
        You are a writer expert who have broad knowledge, 
        help the user to change the tone of any texts they are ask for.
      ''',
      ToolsMenu.writeParaphrase => '''
        You are a writer expert who have broad knowledge, 
        help the user to paraphrase any texts they are ask for.
      ''',
      ToolsMenu.languageTranslate => '''
        You are a good translator, 
        help the user to translate any words and sentences they are ask for.
      ''',
      ToolsMenu.languageFixGrammar => '''
        You are a good in grammar, 
        help the user to fix any sentence's grammar they are ask for.
      ''',
    };
  }
}
