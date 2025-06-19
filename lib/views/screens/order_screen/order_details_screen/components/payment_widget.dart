import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:village_wheels/controllers/order_controller.dart';


class paymentwidget extends StatelessWidget {
  const paymentwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (controller) {
        final items = controller.billItems;
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xffD9D9D9),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: items.map((item) {
                if (item.isTotal) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.label,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Color(0xff93979E),
                                fontSize: 14,
                              ),
                        ),
                        Text(
                          item.value,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Color(0xff93979E),
                                fontSize: 14,
                              ),
                        ),
                      ],
                    ),
                  );
                }
                if (item.label == 'Subtotal') {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.label,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Color(0xff93979E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        Text(
                          item.value,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Color(0xff93979E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    ),
                  );
                }
                if (item.label == 'Handling Fee') {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.label,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Color(0xff93979E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        Text(
                          item.value,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Color(0xff93979E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    ),
                  );
                }
                if (item.label == 'GST') {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.label,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Color(0xff93979E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        Text(
                          item.value,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Color(0xff93979E),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    ),
                  );
                }
                if (item.label == 'Paid Amount') {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.label,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Text(
                          item.value,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.label,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                    item.isFree
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                item.value,
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 16,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              const Text(
                                'Free',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            item.value,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
