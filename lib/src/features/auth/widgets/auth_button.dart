import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/assets/assets.gen.dart';
import '../../../shared/extensions/ext_dimens.dart';
import '../../../shared/extensions/ext_misc.dart';
import '../../../shared/extensions/ext_theme.dart';
import '../../../shared/widgets/global_button.dart';
import '../managers/auth_bloc.dart';

enum AuthButtonType { apple, google }

class AuthButton extends StatelessWidget {
  const AuthButton.apple({super.key}) : type = AuthButtonType.apple;
  const AuthButton.google({super.key}) : type = AuthButtonType.google;
  final AuthButtonType type;

  @override
  Widget build(BuildContext context) {
    return GlobalButton.primary(
      onTap: () {
        switch (type) {
          case AuthButtonType.apple:
            context.read<AuthBloc>().add(const AuthEvent.withApple());
          case AuthButtonType.google:
            context.read<AuthBloc>().add(const AuthEvent.withGoogle());
        }
      },
      foregroundColor: CupertinoColors.white,
      backgroundColor: context.isLightMode
          ? CupertinoColors.black
          : CupertinoColors.systemFill,
      fullWidth: true,
      child: Wrap(
        spacing: context.spacingMd,
        children: [
          switch (type) {
            AuthButtonType.apple => Assets.images.imgApple.svg(),
            AuthButtonType.google => Assets.images.imgGoogle.svg(),
          },
          Text(
            switch (type) {
              AuthButtonType.apple => context.l10n.continueWithApple,
              AuthButtonType.google => context.l10n.continueWithGoogle,
            },
          ),
        ],
      ),
    );
  }
}
