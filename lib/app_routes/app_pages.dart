import 'package:example_background/app_screens/home/view/home_screen.dart';
import 'package:get/get.dart';

import '../app_screens/home/binding/home_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.routeHome,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
