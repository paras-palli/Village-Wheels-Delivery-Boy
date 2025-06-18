import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/assets.dart';

showMaintenanceDialog({required BuildContext context}) {
  return showDialog(
    context: context,
    builder: (context) {
      return const MaintenanceDialog();
    },
  );
}

class MaintenanceDialog extends StatelessWidget {
  const MaintenanceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      child: PopScope(
        canPop: false,
        child: IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Color(0xFF535353), Color(0xFF303030)]
                )
            ),
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Image(
                    image: const AssetImage(Assets.imagesAppLogo),
                    height: size.height * 0.1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "App is Under Maintenance",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          SystemNavigator.pop();
                        },
                        child: Container(
                          height: 40,
                          width: size.width * 0.3,
                          decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                            child: Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
