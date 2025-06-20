import 'package:flutter/material.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';

import 'components/current_order_widget.dart';
import 'components/dashboard_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------- DashBoard ---------
                      const DashboardWidget(),

                      // ------ Shop Closed ----------
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Current Orders",
                              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xffF5F5F5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "3 Orders",
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Color(0xff292D32),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),
                      const CurrentOrderWidget(),
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
