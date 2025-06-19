import 'package:flutter/material.dart';

import 'components/id_components.dart';
import 'components/price_components.dart';
import 'components/stepper_widget.dart';

class OngoingScreen extends StatelessWidget {
  const OngoingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xff6B7280),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const IdComponents(),
                const SizedBox(height: 10),
                Text(
                  "Jun 09 , 2025 - 05:30 am ",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(height: 16),
                StepperWidget(),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      "Order Status: ",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                    ),
                    Text(
                      "Items Packed",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: const Color(0xffE49A23),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "----------------------------------------",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(0xff6B7280),
                      ),
                ),
                const PriceComponents(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
