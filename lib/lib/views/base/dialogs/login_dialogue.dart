import 'dart:developer';

import 'package:flutter/material.dart';

import '../common_button.dart';

showLoginDialogue ({required BuildContext context}) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return const LoginDialog();
    },
  );
}

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  LoginDialogState createState() => LoginDialogState();
}

class LoginDialogState extends State<LoginDialog> {
  @override
  void initState() {
    super.initState();
    log("Login Dialogue run");
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.padding),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.only(left: Constants.padding, top: 30, right: Constants.padding, bottom: Constants.padding),
          margin: const EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(Constants.padding),
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.25), offset: const Offset(0, 5), blurRadius: 5),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 5),
              Center(
                child: Text(
                  '''You're not logged in'''.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF263238),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              // Access to this content requires authentication. Please log in to proceed. If you don't have an account, you may register.
              const SizedBox(height: 15),
              const Center(
                child: Text(
                  '''To continue, you need to authenticate your access. Please log in.''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF46454A),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      type: ButtonType.secondary,
                      elevation: 0,
                      onTap: () {
                        Navigator.pop(context, false);
                      },
                      title: "CANCEL",
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: CustomButton(
                      elevation: 0,
                      onTap: () {
                        // Navigator.push(context, getCustomRoute(child: const LoginScreen()));
                      },
                      title: "LOGIN",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Constants {
  Constants._();

  static const double padding = 20;
  static const double avatarRadius = 45;
}
