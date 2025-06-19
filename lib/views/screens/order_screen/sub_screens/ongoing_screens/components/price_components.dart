import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:village_wheels_delivery_boy/services/route_helper.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';

import '../../../order_details_screen/order_detail_screen.dart';

class PriceComponents extends StatelessWidget {
  const PriceComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "5 Items",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xff6B7280),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(height: 5),
                Text(
                  "₹500 /-",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, getCustomRoute(child: const OrderDetailScreen()));
            },
            child: Row(
              children: [
                Text(
                  "View Details",
                  style: GoogleFonts.roboto(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: primaryColor,
                  size: 16,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
