import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:village_wheels_delivery_boy/generated/assets.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';

class DeliveryPersonName extends StatelessWidget {
  const DeliveryPersonName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Akshay Kumar",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
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
              Assets.svgsTime,
            ),
            const SizedBox(width: 7),
            Text(
              "Pickup ETA : 12mins",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: const Color(0xff808080),
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
              Assets.svgsGtick,
            ),
            const SizedBox(width: 7),
            Text(
              "On the way to pick up",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: const Color(0xff1F9C41),
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
              Assets.svgsScooter,
            ),
            const SizedBox(width: 7),
            Text(
              "Honda Active - MH12 AB 4567",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: const Color(0xff808080),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
