import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../generated/assets.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: SizedBox(
            width: size.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(Assets.lottiesNoInternet, height: 300, width: 300),
                Text("No Connection",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black.withOpacity(0.9),
                      fontSize: 18,
                      letterSpacing: 1,
                      // fontFamily: "Montserrat",
                      fontWeight: FontWeight.w600,
                    )),
                const SizedBox(
                  height: 4,
                ),
                Text("Make sure wifi or cellular data is turned on and then try again.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 14,
                      letterSpacing: 0.3,
                      // fontFamily: "Montserrat",
                      fontWeight: FontWeight.w400,
                    )),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          )),
    );
  }
}
