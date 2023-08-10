import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Timer App')),
      body: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: controller.minuteController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Minutes'),
                        validator: (value) {
                          int? minutes = int.tryParse(value!.toString());
                          if (minutes != null && minutes >= 59) {
                            return 'Minute can not more than 59 minutes';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: controller.secondController,
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(labelText: 'Seconds'),
                        validator: (value) {
                          int? minutes = int.tryParse(value!);
                          if (minutes != null && minutes >= 60) {
                            return 'Second can not more than 60 minutes';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: controller.addTimer,
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
            GetX<HomeController>(
              init: HomeController(),
              builder: (_) {
                if (controller.timerItems.value.isEmpty) {
                  return const Expanded(
                    flex: 8,
                    child: Center(
                      child: Text('No timer added'),
                    ),
                  );
                } else {
                  return Expanded(
                    flex: 8,
                    child: ListView.builder(
                      itemCount: controller.timerItems.value.length,
                      itemBuilder: (context, index) {
                        return controller.timerItems.value[index];
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
