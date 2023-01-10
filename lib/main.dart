import 'dart:async';
import 'package:example_background/app_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'services/service_helper.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///initialize notification and create channel
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: "basic_channel",
      channelName: "basic_channel",
      channelDescription: "service demo bg",
      onlyAlertOnce: true,
      locked: true,
    )
  ]);
  ServiceHelper serviceHelper = ServiceHelper();

  ///service initialization
  await serviceHelper.initializeService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = FlutterBackgroundService();
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: (receivedAction) async {
        print(receivedAction.buttonKeyPressed);
        if (receivedAction.buttonKeyPressed == "stop") {
          service.invoke("stopService");
        }
      },
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomePage(),
    );
  }
}
