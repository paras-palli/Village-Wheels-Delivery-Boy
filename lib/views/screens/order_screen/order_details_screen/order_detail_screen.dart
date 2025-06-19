import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:village_wheels_delivery_boy/generated/assets.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';

import '../sub_screens/ongoing_screens/components/stepper_widget.dart';
import 'components/button_widget.dart';
import 'components/delivery_person_name.dart';
import 'components/online_payment_widget.dart';
import 'components/order_item_screen.dart';
import 'components/payment_widget.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Order Details",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 05),
                child: StepperWidget(),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Text(
                    "Order Status: ",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                  ),
                  Text(
                    "Items Packed",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: const Color(0xffE49A23),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.svgsOrders,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Order Id: 1234567890",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xffE49A23),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "On Going",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Jun 10 , 2025 - 10:20am ",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 25),
              Text(
                "Order Items (2)",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
              ),
              const SizedBox(height: 15),
              const OrderItemScreen(),
              const SizedBox(height: 15),
              const paymentwidget(),
              const SizedBox(height: 15),
              Text(
                "Payment Info",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
              ),
              const SizedBox(height: 10),
              const OnlinePaymentWidget(),
              const SizedBox(height: 20),
              Text(
                "Delivery Person Details",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: const Color(0xff000000),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 10),
              const DeliveryPersonName(),
              const SizedBox(height: 10),
              const buttonWidget(),
              const SizedBox(height: 20),
              Text(
                "User Details",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                "Priya Shetty",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined),
                  const SizedBox(width: 7),
                  Text(
                    "Currently 2.3 km from store",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SvgPicture.asset(
                    Assets.svgsContact,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    "Contact Number : +91 98764 32100  ",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: const Color(0xffB5B8BF),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Assets.svgsAddress,
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      "Delivery Address :  \n24-17-45, Srinivas Nagar,Near RTC Bus Stand,Guntur, Andhra Pradesh – 522002",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: const Color(0xff808080),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
