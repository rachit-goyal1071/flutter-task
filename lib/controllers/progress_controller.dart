import 'dart:async';
import 'package:get/get.dart';

class ProgressController extends GetxController {
  var progress = 0.0.obs;
  Timer? _timer;
  var time = 30.obs;

  @override
  void onInit() {
    super.onInit();
    _startAnimation(time.value);
  }

  void setProgress(double value) {
    progress.value = value.clamp(0.0, 1.0);
  }

  void setSpeed(double speed) {
    time.value = (30 / (speed + 1)).toInt();
    _restartAnimation(time.value);
  }

  void _startAnimation(int durationMilliseconds) {
    _timer?.cancel();

    progress.value = 0.0; // Reset progress to 0.0

    _timer = Timer.periodic(Duration(milliseconds: durationMilliseconds), (timer) {
      if (progress.value >= 1.0) {
        progress.value = 0.0; // Reset progress when it reaches 1.0
      } else {
        progress.value += 0.01; // Increment progress
      }
    });
  }

  void _restartAnimation(int durationMilliseconds) {
    _startAnimation(durationMilliseconds);
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel the timer when the controller is disposed
    super.onClose();
  }
}
