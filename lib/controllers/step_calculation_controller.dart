import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pedometer/pedometer.dart';
import 'package:logger/logger.dart';

class StepCalculationController extends GetxController {
  RxInt stepCount = 0.obs;
  int _initialSteps = 0;
  late Stream<StepCount> _stepCountStream;
  var logger = Logger();

  @override
  void onInit() {
    super.onInit();
    requestPermissionAndInit();
  }

  Future<void> requestPermissionAndInit() async {
    final status = await Permission.activityRecognition.status;

    if (status.isGranted) {
      initPedometer();
    } else {
      final result = await Permission.activityRecognition.request();
      if (result.isGranted) {
        initPedometer();
      } else {
        stepCount.value = 0;
        logger.e('Permission denied: ACTIVITY_RECOGNITION');
      }
    }
  }

  void initPedometer() {
    _stepCountStream = Pedometer.stepCountStream;

    _stepCountStream.listen(
      onStepCount,
      onError: onStepCountError,
      cancelOnError: true,
    );
  }

  void onStepCount(StepCount event) {
    if (_initialSteps == 0) {
      _initialSteps = event.steps;
    }
    stepCount.value = event.steps - _initialSteps;
    logger.i('Step Count: ${stepCount.value}');
  }

  void onStepCountError(error) {
    logger.e('Step Count Error: $error');
    stepCount.value = 0;
  }

  void resetStepCount() {
    _initialSteps = 0;  // Reset baseline
    stepCount.value = 0;
    logger.i('Step count reset.');
  }

  @override
  void onClose() {
    super.onClose();
  }
}
