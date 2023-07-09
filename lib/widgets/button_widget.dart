import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodels/button_widget_viewmodel.dart';

class ButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const ButtonWidget({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ButtonWidgetViewModel>(
      init: ButtonWidgetViewModel(),
      global: false,
      builder: (buttonController) {
        return GestureDetector(
          onTapDown: (_) {
            onTap?.call();
            buttonController.increaseButtonSize();
          },
          onTapUp: (details) => buttonController.restoreButtonSize(),
          onTapCancel: buttonController.restoreButtonSize,
          child: AnimatedBuilder(
            animation: buttonController.animationController,
            builder: (BuildContext context, Widget? child) {
              return Transform.scale(
                scale: buttonController.animationController.value,
                child: child,
              );
            },
            child: child,
          ),
        );
      },
    );
  }
}
