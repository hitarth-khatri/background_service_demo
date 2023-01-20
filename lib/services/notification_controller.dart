import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:example_background/app_screens/home/controller/home_controller.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';

class NotificationController {

  ///initialize notification and create channel
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: "basic_channel",
          channelName: "basic_channel",
          channelDescription: "service demo bg",
          onlyAlertOnce: true,
          locked: true,
        )
      ],
    );
  }

  ///create new notification
  static Future<void> createNewNotification(lat, long) async {
    await AwesomeNotifications().createNotification(
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
  }

  ///action button click
  static Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
    final service = FlutterBackgroundService();
    final homeController = Get.find<HomeController>();
    if (receivedAction.buttonKeyPressed == "stop") {
      homeController.isService.value = false;
      service.invoke("stopService");
    }
  }

  static Future<void> startListeningNotificationEvents() async {
    AwesomeNotifications().setListeners(onActionReceivedMethod: onActionReceivedMethod);
  }
}
