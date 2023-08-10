import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/components/TimerItem.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  TextEditingController minuteController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  RxList<TimerItem> timerItems = List<TimerItem>.empty(growable: true).obs;
  int timerCount = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void addTimer() {
    int minutes = int.tryParse(minuteController.text) ?? 0;
    int seconds = int.tryParse(secondController.text) ?? 0;

    if (timerItems.length >= 10) {
      Get.snackbar('Sorry you can\'t add more than 10 timer', '');
    } else if (minutes >= 0 && minutes <= 59 && seconds >= 0 && seconds <= 59) {
      timerItems.add(TimerItem(
        minutes: minutes,
        seconds: seconds,
        index: timerItems.length,
      ));
      // timerItems.insert(
      //     0,
      //     TimerItem(
      //       minutes: minutes,
      //       seconds: seconds,
      //       index: timerCount,
      //     ));

      minuteController.clear();
      secondController.clear();
      timerCount += 1;
    }
  }

  void removeTimer(int index) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      timerItems.removeAt(index);
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
