import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:village_wheels/generated/assets.dart';

class OrderIdComponents extends StatelessWidget {
  const OrderIdComponents({super.key, required this.color, required this.text});
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          Assets.svgsOrder,
          fit: BoxFit.cover,
          height: 24,
          width: 24,
        ),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            "ORD - 216786179",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
      ],
    );
  }
}
