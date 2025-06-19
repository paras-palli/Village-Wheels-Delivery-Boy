import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:village_wheels/services/theme.dart';

import 'package:village_wheels/views/screens/orders_screens/delivered_screens/components/order_id_components.dart';

class DeliverdScreen extends StatelessWidget {
  const DeliverdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color(0xff6B7280),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderIdComponents(
                  color: Color(0xff1F9C41),
                  text: "Delivered",
                ),
                SizedBox(height: 10),
                Text(
                  "Jun 10 , 2025 - 10:20am ",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                SizedBox(height: 30),
                Text(
                  "----------------------------------------------",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Color(0xff6B7280),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "2 items",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Color(0xff6B7280),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                          Text(
                            "₹300 /-",
                            style: GoogleFonts.roboto(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "View Details",
                      style: GoogleFonts.roboto(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(width: 05),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: primaryColor,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
