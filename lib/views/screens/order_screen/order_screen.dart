import 'package:flutter/material.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';

import 'sub_screens/ongoing_screens/ongoing_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              labelColor: primaryColor,
              unselectedLabelColor: fontGrey,
              indicatorColor: primaryColor,
              dividerHeight: 1,
              dividerColor: fontGrey,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 2,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
              labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: primaryColor, fontSize: 15, fontWeight: FontWeight.w500),
              unselectedLabelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: fontGrey,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: "Ongoing"),
                Tab(text: "Delivered"),
                Tab(text: "Cancelled"),
              ],
            ),
            Expanded(
              child: const TabBarView(
                children: [
                  OngoingScreen(),
                  OngoingScreen(),
                  OngoingScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
