import 'package:get/get.dart';
import 'dart:async';

class ProgressController extends GetxController {
  var progress = 0.0.obs; // Observable for the progress value
  var speed = 1.0.obs; // Speed control from the slider
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    _startAnimation();
  }

  void _startAnimation() {
    _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (progress.value >= 1.0) {
        progress.value = 0.0; // Reset progress
      } else {
        progress.value += 0.01; // Update the progress value
      }
    });
  }

  void setSpeed(double newSpeed) {
    speed.value = newSpeed;
    _restartAnimation();
  }

  void _restartAnimation() {
    _timer.cancel();
    _startAnimation();
  }

  @override
  void onClose() {
    _timer.cancel(); // Cancel the timer when the controller is disposed
    super.onClose();
  }
}
