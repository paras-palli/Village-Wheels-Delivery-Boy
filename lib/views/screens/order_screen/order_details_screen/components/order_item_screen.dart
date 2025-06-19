import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:village_wheels_delivery_boy/controllers/order_controller/order_controller.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_image.dart';

class OrderItemScreen extends StatelessWidget {
  const OrderItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (controller) {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.orderItems.length,
          itemBuilder: (context, index) {
            final item = controller.orderItems[index];
            log(item.name);
            log(item.quantity.toString());
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(0xffD9D9D9),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  CustomImage(
                    path: item.imageUrl,
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                        ),
                        Text(
                          "Unit: ${item.unit}",
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                  ),
                        ),
                        Text(
                          "₹ ${item.price.toStringAsFixed(0)}",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Quantity: ${item.quantity}',
                      style: GoogleFonts.roboto(
                        color: Color(0xff6B7280),
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
