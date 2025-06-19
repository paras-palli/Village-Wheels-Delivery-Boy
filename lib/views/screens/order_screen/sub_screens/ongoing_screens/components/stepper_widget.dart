import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:village_wheels_delivery_boy/controllers/order_controller/order_controller.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';

class StepperWidget extends StatelessWidget {
  const StepperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: List.generate(
              controller.totalSteps * 2 - 1,
              (index) {
                if (index.isEven) {
                  int stepIndex = index ~/ 2.5;
                  bool isCompleted = stepIndex < controller.currentStep;
                  bool isActive = stepIndex == controller.currentStep;

                  return Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      color: isCompleted || isActive ? orange : fontGrey,
                      shape: BoxShape.circle,
                    ),
                  );
                } else {
                  int leftStep = (index - 1) ~/ 3;
                  bool isCompleted = leftStep < controller.currentStep;

                  return Expanded(
                    child: Container(
                      height: 2,
                      color: isCompleted ? orange : fontGrey,
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
