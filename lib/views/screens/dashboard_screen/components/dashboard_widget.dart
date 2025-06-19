import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:village_wheels_delivery_boy/generated/assets.dart';
import 'package:village_wheels_delivery_boy/services/constants.dart';
import 'package:village_wheels_delivery_boy/services/theme.dart';
import 'package:village_wheels_delivery_boy/views/base/dotted_line.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.green, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today’s Business',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(width: 10),
                      Text(
                        'INR ${PriceConverter.convertToNumberFormat(152)}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: false ? Colors.red : Colors.green,
                          fontSize: 26,
                        ),
                      ),

                      const SizedBox(height: 13),
                      Row(
                        children: [
                          const Icon(
                            Icons.credit_card,
                            size: 14,
                          ),
                          const SizedBox(width: 10),
                          RichText(
                            text: TextSpan(
                                text: 'Online - ',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                ),
                                children: [
                                  TextSpan(
                                    text: PriceConverter.convertToNumberFormat(55.2),
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                      fontSize: 11,
                                    ),
                                  )
                                ]
                            ),
                          ),

                          const SizedBox(width: 20),
                          SvgPicture.asset(
                            Assets.svgsCoins,
                            width: 14,
                            height: 14,
                          ),
                          const SizedBox(width: 10),
                          RichText(
                            text: TextSpan(
                                text: 'Cash - ',
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                ),
                                children: [
                                  TextSpan(
                                    text: PriceConverter.convertToNumberFormat(150),
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                      fontSize: 11,
                                    ),
                                  )
                                ]
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  const Spacer(),
                  SizedBox(
                    height: 90,
                    child: DottedLine(
                      isVertical: true,
                      dashWidth: 8,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const Spacer(),

                  Column(
                    children: [
                      SvgPicture.asset(
                        Assets.svgsClock,
                        width: 18,
                        height: 18,
                      ),

                      const SizedBox(height: 6),
                      Text(
                        'Today’s Order',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),

                      Text(
                        '10',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 14),
              DottedLine(color: Colors.grey.shade400, dashWidth: 8),
              const SizedBox(height: 14),

              GestureDetector(
                onTap: () {
                  // Navigator.push(context, getCustomRoute(child: const SettlementLedger()));
                },
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Upcoming settlement - ',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                          children: [
                            TextSpan(
                              text: 'INR 500',
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: false ? Colors.red : Colors.green,
                                fontSize: 13,
                              ),
                            )
                          ]
                      ),
                    ),

                    const Spacer(),
                    Text(
                      'View details',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontSize: 13,
                        color: Colors.deepOrangeAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
