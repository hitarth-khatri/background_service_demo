// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:ui';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';

class ServiceHelper {
  ///initialize service
  Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    /*///create channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'my_foreground', //id
      'MY FOREGROUND SERVICE', //name
      importance: Importance.low,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);*/

    await permissionHandler();

    await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: 'basic_channel',
        initialNotificationTitle: "Starting service",
        initialNotificationContent: "waiting",
        foregroundServiceNotificationId: 888,
      ),
    );
    service.startService();
  }

  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final AwesomeNotifications awesomeNotifications = AwesomeNotifications();

    if (service is AndroidServiceInstance) {
      ///foreground
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      ///background
      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

    ///stop service
    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        ///get position
        String? lat;
        String? long;
        Geolocator.getPositionStream().listen(
          (position) {
            lat = position.latitude.toString();
            long = position.longitude.toString();
            print("position: $lat, $long");
          },
        );

        ///show notification
        Timer.periodic(
          const Duration(seconds: 1),
          (timer) {
            awesomeNotifications.createNotification(
              content: NotificationContent(
                id: 888,
                channelKey: "basic_channel",
                title: "Lat : $lat",
                body: "Long: $long",
              ),
              actionButtons: [
                NotificationActionButton(key: "stop", label: "Stop"),
              ],
            );

            /*flutterLocalNotificationsPlugin.show(
              888,
              "Latitude : $lat",
              "Longitude: $long",
              const NotificationDetails(
                android: AndroidNotificationDetails(
                  'my_foreground',
                  'MY FOREGROUND SERVICE',
                  icon: 'ic_bg_service_small',
                  ongoing: true,
                  onlyAlertOnce: true,
                ),
              ),
            );*/
          },
        );
      }
    }
  }

  static permissionHandler() async {
    LocationPermission? permission;
    print("permission: $permission");
    permission = await Geolocator.requestPermission();
    print("permission: $permission");
    if (permission == LocationPermission.deniedForever) {
      Geolocator.openAppSettings();
    }
  }

/*static Future<bool> notify() async {
    final AwesomeNotifications awesomeNotifications = AwesomeNotifications();
    return awesomeNotifications.createNotification(
      content: NotificationContent(id: 1, channelKey: "service_demo"),
      actionButtons: [
        NotificationActionButton(key: "stop", label: "Stop"),
      ],
    );
  }*/
}
