import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var service = FlutterBackgroundService();
  var text = "".obs;
  var isService = true.obs;

  @override
  void onInit() {
    checkStatus().then((value) {
      if(value) {
        isService.value= true;
      }
      else {
        isService.value = false;
      }
    });
    super.onInit();
  }

  Future checkStatus() async {
    if (await service.isRunning()) {
      return true;
    } else {
      return false;
    }
  }

}