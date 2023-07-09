import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class ButtonWidgetViewModel extends GetxController with GetTickerProviderStateMixin {
  static const clickAnimationDurationMillis = 100;
  late final AnimationController animationController;

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: clickAnimationDurationMillis),
      lowerBound: 1.0,
      upperBound: 1.1,
    );
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void increaseButtonSize() {
    animationController.forward();
  }

  void restoreButtonSize() {
    Future.delayed(
      const Duration(milliseconds: clickAnimationDurationMillis),
      () => animationController.reverse(),
    );
  }
}
