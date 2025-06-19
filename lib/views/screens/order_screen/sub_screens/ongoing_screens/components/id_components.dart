import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:village_wheels_delivery_boy/generated/assets.dart';

class IdComponents extends StatelessWidget {
  const IdComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          Assets.svgsOrders,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 10),
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
            color: Color(0xffE49A23),
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
    );
  }
}
