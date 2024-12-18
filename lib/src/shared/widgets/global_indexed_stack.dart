import 'package:flutter/material.dart';

class GlobalIndexedStack extends StatefulWidget {
  const GlobalIndexedStack({super.key, this.index, this.children});

  final int? index;
  final List<Widget>? children;

  @override
  State<GlobalIndexedStack> createState() => _GlobalIndexedStackState();
}

class _GlobalIndexedStackState extends State<GlobalIndexedStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  final duration = const Duration(milliseconds: 500);

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: duration);
    controller.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GlobalIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) controller.forward(from: 0.0);
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: controller,
      child: IndexedStack(
        index: widget.index,
        alignment: Alignment.center,
        children: widget.children ?? [],
      ),
    );
  }
}
