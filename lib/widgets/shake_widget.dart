import 'dart:math';
import 'package:flutter/material.dart';

import '../viewmodels/shake_widget_viewmodel.dart';

class ShakeWidget extends StatelessWidget {
  final Widget child;
  final double shakeOffset;
  final int shakeCount;
  final ShakeWidgetViewModel shakeKey;
  const ShakeWidget(
      {super.key,
      required this.child,
      this.shakeOffset = 5,
      this.shakeCount = 3,
      required this.shakeKey});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: shakeKey.animationController,
      child: child,
      builder: (context, child) {
        final sineValue =
            sin(shakeCount * 2 * pi * shakeKey.animationController.value);
        return Transform.translate(
          offset: Offset(sineValue * shakeOffset, 0),
          child: child,
        );
      },
    );
  }
}
