import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String content, SnackBarAction? snackBarAction}) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      elevation: 6,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Row(
        children: [
          const Icon(
            Icons.info,
            color: Colors.white,
          ), // Add your icon here
          const SizedBox(width: 15), // Add some spacing between the icon and text
          Expanded(
            child: Text(
              content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 4000),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      behavior: SnackBarBehavior.floating,
      // Change behavior to floating

      action: snackBarAction,
    ),
  );
}
