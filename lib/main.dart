import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';

import 'services/constants.dart';
import 'services/init.dart';
import 'services/theme.dart';
import 'views/base/no_internet_screen.dart';
import 'views/screens/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.request();
  await Init().initialize();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> snackBarKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool isConnected = true;

  initNotificationOneSignal() async {
    OneSignal.initialize('appId');
    OneSignal.User.pushSubscription.optIn();
    await OneSignal.consentRequired(true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    log('Current state = $state');
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initNotificationOneSignal();
    checkConnection();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown,]);
  }

  checkConnection() async {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> connectivityResults) {
      final hasConnection = connectivityResults.contains(ConnectivityResult.mobile) || connectivityResults.contains(ConnectivityResult.wifi);

      if (hasConnection) {
        log("InterNet is here!");
        isConnected = true;
      } else {
        log("InterNet are lost!");
        isConnected = false;
      }

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: AppConstants.appName,
        navigatorKey: navigatorKey,
        themeMode: ThemeMode.light,
        theme: CustomTheme.light,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        builder: (context, child) {
          return Stack(
            children: [
              child ?? const SplashScreen(),

              if (!isConnected) const NoInternet(),
            ],
          );
        },
      ),
    );
  }
}
