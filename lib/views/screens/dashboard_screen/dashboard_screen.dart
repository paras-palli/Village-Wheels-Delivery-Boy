import 'package:flutter/material.dart';
import 'package:village_wheels_delivery_boy/generated/assets.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';

import 'components/dashboard_widget.dart';
import 'components/drawer_widget.dart';

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
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: primaryColor,
          color: Colors.white,
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: Colors.grey[200]),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------- DashBoard ---------
                      const DashboardWidget(),

                      // ------ Shop Closed ----------
                      const SizedBox(height: 25),
                      // const ShopClosedButtonWidget(),
                      // --------- Orders ----------
                      // OrderWidget(size: size),
                      // ------- Order Bucket Grid --------
                      const SizedBox(height: 6),
                      // const OrderBucketScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const SizedBox(height: 20),
    );
  }
}
