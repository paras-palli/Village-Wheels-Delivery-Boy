import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../generated/assets.dart';

Future<dynamic> showUpdateDialogue({required BuildContext context, bool skip = false}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return UpdateDialog(skip: skip);
    },
  );
}

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({super.key, required this.skip, this.remark = ''});

  final bool skip;
  final String remark;

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
                  Center(
                    child: Text(
                      "Update App",
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (skip)
                        InkWell(
                          onTap: () {
                            Navigator.pop(context, false);
                          },
                          child: Container(
                            height: 40,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(5)),
                            child: const Center(
                              child: Text(
                                'Later',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      if (skip)
                        const SizedBox(
                          width: 10,
                        ),
                      InkWell(
                        onTap: () async {
                          if (GetPlatform.isAndroid) {
                            // ExtraMethods.launchInBrowser(Get.find<BasicController>().settings?.appDownload ?? 'https://play.google.com/store/apps/details?id=com.jaihobabag');
                          } else {
                            // ExtraMethods.launchInBrowser(Get.find<BasicController>().settings?.iosAppDownload ?? 'https://apps.apple.com/us/app/way2sports/id1630920516');
                          }
                        },
                        child: Container(
                          height: 40,
                          width: size.width * 0.3,
                          decoration: BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                            child: Text(
                              'Update Now',
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
