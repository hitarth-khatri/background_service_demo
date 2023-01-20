import 'dart:async';
import 'package:example_background/app_routes/app_pages.dart';
import 'package:example_background/app_screens/home/view/home_screen.dart';
import 'package:example_background/app_screens/splash_screen.dart';
import 'package:example_background/services/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'services/service_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///notification initialization
  await NotificationController.initializeNotification();

  ///service initialization
  await ServiceHelper().initializeService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ///handle notification button click
    NotificationController.startListeningNotificationEvents();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const SplashScreen(),
      getPages: AppPages.pages,
    );
  }
}
