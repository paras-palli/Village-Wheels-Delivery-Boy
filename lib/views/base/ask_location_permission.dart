// import 'package:flutter/material.dart';
// import 'package:get/instance_manager.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:village_wheels_delivery_boy/lib/controllers/PermissionController.dart';
// import 'package:village_wheels_delivery_boy/lib/generated/assets.dart';
//
// import '../../services/theme.dart';
// import 'common_button.dart';
//
// class AskMeLocationScreen extends StatefulWidget {
//   const AskMeLocationScreen({super.key});
//
//   @override
//   State<AskMeLocationScreen> createState() => _AskMeLocationScreenState();
// }
//
// class _AskMeLocationScreenState extends State<AskMeLocationScreen> {
//   bool isPermissionDenied = false;
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       Permission.location.isPermanentlyDenied.then((value) {
//         if (value == true) {
//           setState(() {
//             isPermissionDenied = true;
//           });
//         }
//       });
//     });
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//       ),
//       body: Container(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 16,
//         ),
//         width: size.width,
//         alignment: Alignment.center,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const SizedBox(
//               height: 30,
//             ),
//             Text(
//               "Location".toUpperCase(),
//               style: Theme.of(context).textTheme.labelLarge,
//             ),
//             Text(
//               "Locate Properties\nClose to You ?",
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.headlineLarge!.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: textPrimary,
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Image.asset(
//               Assets.imagesLocationAccess,
//               width: size.width * 0.8,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Text(
//               textAlign: TextAlign.center,
//               "Enhance your efficiency by finding nearby properties specifically tailored to your geographic area. Start your search now and streamline your workflow with local opportunities.",
//               style: Theme.of(context).textTheme.labelLarge!.copyWith(
//                 height: 1.4,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               textAlign: TextAlign.center,
//               "Please note that location permission is required to access properties in your area.",
//               style: Theme.of(context).textTheme.labelLarge!.copyWith(
//                 height: 1.2,
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: SizedBox(
//             height: 45,
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Expanded(
//                   child: CustomButton(
//                     radius: 4,
//                     onTap: () async {
//                       if (!isPermissionDenied) {
//                         await Get.find<PermissionController>().getPermission(Permission.location, context);
//                       }
//                       if (context.mounted) {
//                         Navigator.pushAndRemoveUntil(context, getCustomRoute(child: const DashboardScreen()), (route) => false);
//                       }
//                     },
//                     title: isPermissionDenied ? "Explore" : 'Continue',
//                   ),
//                 ),
//
//                 if (isPermissionDenied)
//                   const SizedBox(width: 10),
//
//                 if (isPermissionDenied)
//                   Expanded(
//                     flex: 2,
//                     child: CustomButton(
//                       radius: 4,
//                       onTap: () async {
//                         await openAppSettings().then((value) {
//                           Navigator.pushAndRemoveUntil(
//                             context,
//                             getCustomRoute(child: const DashboardScreen()),
//                                 (route) => false,
//                           );
//                         });
//                       },
//                       title: "Open App Settings",
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
