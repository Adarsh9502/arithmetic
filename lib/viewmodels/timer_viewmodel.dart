import 'dart:async';
import 'package:get/get.dart';

class TimerViewModel extends GetxController {
  Rx<Duration> duration = const Duration().obs;
  Timer? timer;
  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    timer?.cancel();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) => addTime());
  }

  void addTime() {
    const addSeconds = 1;
    final seconds = duration.value.inSeconds + addSeconds;
    duration.value = Duration(seconds: seconds);
  }

  void resetTimer() {
    timer?.cancel();
  }

  void restartTimer() {
    duration.value = const Duration();
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  String get minutes => twoDigits(duration.value.inMinutes.remainder(60));
  String get seconds => twoDigits(duration.value.inSeconds.remainder(60));

  String get getTime => '$minutes:$seconds';
}
