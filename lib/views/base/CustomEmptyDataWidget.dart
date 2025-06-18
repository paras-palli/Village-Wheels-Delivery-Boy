import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import 'lottie_builder.dart';

class EmptyWidget extends StatefulWidget {
  const EmptyWidget({super.key, this.title, this.description});

  final String? title;
  final String? description;

  @override
  State<EmptyWidget> createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
        child: SizedBox(
      width: size.width * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomLottie(
            assetLottie: Assets.lottiesNoSearch,
            height: 150,
            width: 160,
          ),
          Text(
            widget.title ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.description ?? "",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ],
      ),
    ));
  }
}
