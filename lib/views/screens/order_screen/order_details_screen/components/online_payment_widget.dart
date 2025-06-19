import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:village_wheels_delivery_boy/generated/assets.dart';

class onlinePaymentWidget extends StatelessWidget {
  const onlinePaymentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Color(0xffE0E0E0),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            width: 50,
            Assets.svgsOnline,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Text(
            "Online payment",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
          ),
        ],
      ),
    );
  }
}
