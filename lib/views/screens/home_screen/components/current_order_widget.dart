import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';
import 'package:village_wheels_delivery_boy/views/base/custom_image.dart';

class CurrentOrderWidget extends StatelessWidget {
  const CurrentOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: greyLight,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Orders #1",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "1 kg  |  2 items",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: green,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "Confirm",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "Reject",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  "---------------------------------------",
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: const Color(0xffD9D9D9),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const CustomImage(
                path: Assets.imagesMilk,
                width: 100,
                height: 100,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Tata Sampann Toor Dal",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "Unit : 1 Kg",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "Quantity : 2",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "₹171",
                    style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "---------------------------------------",
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: const Color(0xffD9D9D9),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Delivery address: ",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: Text(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  "123 Main St, Apt 4B",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
