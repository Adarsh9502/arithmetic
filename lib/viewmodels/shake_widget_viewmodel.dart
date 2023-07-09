import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class ShakeWidgetViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  static const shakeAnimationDurationMillis = 500;
  late final AnimationController animationController;

  @override
  void onInit() {
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: shakeAnimationDurationMillis))
      ..addStatusListener(_updateStatus);
    super.onInit();
  }

  @override
  void onClose() {
    animationController.removeStatusListener(_updateStatus);
    animationController.dispose();
    super.onClose();
  }

  void _updateStatus(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  void shake() {
    animationController.forward();
  }
}
