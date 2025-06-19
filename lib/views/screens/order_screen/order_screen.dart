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
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text(
            "Orders",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          bottom: TabBar(
            labelColor: primaryColor,
            unselectedLabelColor: fontGrey,
            indicatorColor: primaryColor,
            dividerHeight: 1,
            dividerColor: fontGrey,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 2,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
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
        ),
        body: const TabBarView(
          children: [
            OngoingScreen(),
            OngoingScreen(),
            OngoingScreen(),
            // DeliverdScreen(),
            // CancelledScreen(),
          ],
        ),
      ),
    );
  }
}
