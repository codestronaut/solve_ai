import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalDivider extends StatelessWidget {
  const GlobalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: CupertinoColors.opaqueSeparator.resolveFrom(context),
      thickness: 1.0,
      height: 0.0,
    );
  }
}
