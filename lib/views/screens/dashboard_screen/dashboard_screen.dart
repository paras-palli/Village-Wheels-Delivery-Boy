import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:village_wheels_delivery_boy/controllers/dashboard_controller.dart';
import 'package:village_wheels_delivery_boy/generated/assets.dart';
import 'package:village_wheels_delivery_boy/views/screens/order_screen/order_screen.dart';

import '../home_screen/home_screen.dart';
import 'components/bottom_widget.dart';
import 'components/drawer/drawer_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerScreens(),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Village Wheels ',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: '\nDelivery Boy',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      body: GetBuilder<DashBoardController>(
        initState: (_) {

        },
        builder: (controller) {
          return [
            const HomeScreen(),
            const OrderScreen(),
          ][controller.dashPage];
        },
      ),
      bottomNavigationBar: GetBuilder<DashBoardController>(
        builder: (DashBoardController controller) {
          return BottomAppBar(
            surfaceTintColor: Colors.white,
            padding: EdgeInsets.zero,
            height: 65,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, boxShadow: [
                  BoxShadow(
                    blurRadius: 3.5,
                    spreadRadius: 1.5,
                    color: Colors.grey.withValues(alpha: .4),
                    offset: const Offset(1, 0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  BottomWidget(
                    title: 'Home',
                    icon: Assets.svgsHome,
                    isActive: controller.dashPage == 0,
                    onTap: () => controller.dashPage = 0,
                  ),

                  BottomWidget(
                    title: 'Orders',
                    icon: Assets.svgsOrders,
                    isActive: controller.dashPage == 1,
                    onTap: () => controller.dashPage = 1,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
